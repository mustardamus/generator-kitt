yeoman       = require('yeoman-generator')
_            = require('lodash')
prompts      = require('./prompts')
dependencies = require('./dependencies')
templates    = require('./templates')

module.exports = yeoman.generators.Base.extend
  prompting: ->
    done = @async()

    @prompt prompts, (answers) =>
      @config.answers = answers
      done()

  configuring: ->
    @config.answers.client = {}

    for tool in @config.answers.toolsClient
      @config.answers.client[tool] = true

    if @config.answers.client.jquery and @config.answers.client.zepto
      @config.answers.client.zepto = null # coose jquery over zepto if both selected

    if !@config.answers.client.jquery and !@config.answers.client.zepto
      @config.answers.client.nolib = true # if no library is selected set this

    if @config.answers.client.backbone
      if @config.answers.client.nolib
        @config.answers.client.zepto = true # cant use backbone without $
        @config.answers.client.nolib = null

      unless @config.answers.client.lodash
        @config.answers.client.lodash = true # cant use backbone without _

  writing:
    copyBase: ->
      files = templates.compile(templates.baseTemplates, @config.answers)

      for file in files
        @dest.write file.fileOut, file.content

    buildScriptVendor: ->
      content = []

      for name, path of dependencies.scriptVendorMap
        if _.indexOf(@config.answers.toolsClient, name) isnt -1
          content.push "//= require ../bower_components/#{path}"

      @dest.write 'client/scripts/vendor.js', content.join('\n')

  _install: # remove _ to make it work
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
