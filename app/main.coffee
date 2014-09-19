yeoman       = require('yeoman-generator')
_            = require('lodash')
prompts      = require('./prompts')
dependencies = require('./dependencies')
templates    = require('./templates')
fileUtil     = yeoman.file

module.exports = yeoman.generators.Base.extend
  prompting: ->
    done = @async()

    @prompt prompts, (answers) =>
      @config.answers = answers
      done()

  configuring:
    configureClient: ->
      @config.answers.client = client = {}

      for tool in @config.answers.toolsClient
        @config.answers.client[tool] = client[tool] = true

      unless client.jquery
        @config.answers.client.nolib = true # if no library is selected set this

      if client.backbone
        if client.nolib
          @config.answers.client.jquery = true # cant use backbone without $
          @config.answers.client.nolib = null
          @config.answers.toolsClient.push 'jquery'

        unless client.underscore
          @config.answers.client.underscore = true # cant use backbone without _
          @config.answers.toolsClient.push 'underscore'

      if client.foundation
        unless client['normalize-css']
          @config.answers.client['normalize-css'] = true
          @config.answers.toolsClient.push 'normalize-css'

        unless client.fastclick
          @config.answers.client.fastclick = true
          @config.answers.toolsClient.push 'fastclick'

    configureServer: ->
      @config.answers.server = server = {}

      for tool in @config.answers.toolsServer
        @config.answers.server[tool] = server[tool] = true

  writing:
    copyBase: ->
      files = templates.compile(templates.baseTemplates, @config.answers)

      for file in files
        @dest.write file.fileOut, file.content

      @src.copy 'client/images/favicon.png', 'client/images/favicon.png'

    copyBackbone: ->
      return unless @config.answers.client.backbone

      root  = 'client/scripts'
      files = ['routers.coffee', 'routers/app.coffee', 'views/layout/layout.coffee']
      dirs  = ['collections', 'models', 'templates']

      for file in files
        @src.copy "#{root}/#{file}", "#{root}/#{file}"

      for dir in dirs
        @dest.mkdir "#{root}/#{dir}"

    copyServer: ->
      return unless @config.answers.toolsServer.length

      files = templates.compile(templates.serverTemplates, @config.answers)

      for file in files
        @dest.write file.fileOut, file.content

      if @config.answers.server.express
        @src.copy 'server/routes/app.coffee', 'server/routes/app.coffee'
        @src.copy 'server/helpers/app.coffee', 'server/helpers/app.coffee'

      if @config.answers.server.mongoose
        @src.copy 'server/models/count.coffee', 'server/models/count.coffee'

  install: # remove _ to make it work
    installBower: ->
      done = @async()
      @bowerInstall @config.answers.toolsClient, { 'save': true }, done

    installGulp: ->
      done      = @async()
      gulpDeps  = dependencies.getGulpDependencies()
      otherDeps = dependencies.otherNpmDependencies

      @npmInstall gulpDeps.concat(otherDeps), { 'save-dev': true }, done

    installNpm: ->
      done = @async()
      @npmInstall @config.answers.toolsServer, { 'save': true }, done

  end:
    writeBowerVendorFiles: ->
      tools    = @config.answers.toolsClient
      rootDir  = "#{@destinationRoot()}/client"
      bowerDir = "#{rootDir}/bower_components"
      prefix   = '//= require ../bower_components'
      deps     = dependencies.getBowerDependencies(tools, bowerDir, prefix)

      # @dest.write does not work here, dunno.
      fileUtil.write "#{rootDir}/scripts/vendor.js", deps.scripts.join('\n')
      fileUtil.write "#{rootDir}/styles/vendor.css", deps.styles.join('\n')

      for toolDir in deps.missing
        @log "Cant find bower.json in #{toolDir} - Include it by hand, in dependencies.coffee or choose another package"

      for toolDir in deps.unknown
        @log "Cant find the main field in in #{toolDir}/bower.json - Include it by hand, in dependencies.coffee or choose another package"

      @spawnCommand 'gulp', ['build']
      @log 'Everything done. Go nuts. To start the server do: gulp server'
