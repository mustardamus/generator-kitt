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

  configuring: ->
    @config.answers.client = client = {}

    for tool in @config.answers.toolsClient
      @config.answers.client[tool] = client[tool] = true

    if client.jquery and client.zepto # coose jquery over zepto if both selected
      @config.answers.client.zepto = null
      @config.answers.toolsClient = _.remove(@config.answers.toolsClient, 'zepto')

    if !client.jquery and !client.zepto
      @config.answers.client.nolib = true # if no library is selected set this

    if client.backbone
      if client.nolib
        @config.answers.client.zepto = true # cant use backbone without $
        @config.answers.client.nolib = null
        @config.answers.toolsClient.push 'zepto'

      unless client.lodash
        @config.answers.client.lodash = true # cant use backbone without _
        @config.answers.toolsClient.push 'lodash'

    if client.foundation
      unless client['normalize-css']
        @config.answers.client['normalize-css'] = true
        @config.answers.toolsClient.push 'normalize-css'

      unless client.fastclick
        @config.answers.client.fastclick = true
        @config.answers.toolsClient.push 'fastclick'

  writing:
    copyBase: ->
      files = templates.compile(templates.baseTemplates, @config.answers)

      for file in files
        @dest.write file.fileOut, file.content

  install: # remove _ to make it work
    installBower: ->
      done = @async()
      @bowerInstall @config.answers.toolsClient, { 'save': true }, done

    _installGulp: ->
      done      = @async()
      gulpDeps  = dependencies.getGulpDependencies()
      otherDeps = dependencies.otherNpmDependencies

      @npmInstall gulpDeps.concat(otherDeps), { 'save-dev': true }, done

    _installNpm: ->
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
