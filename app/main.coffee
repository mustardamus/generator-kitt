yeoman       = require('yeoman-generator')
prompts      = require('./prompts')
dependencies = require('./dependencies')

module.exports = yeoman.generators.Base.extend
  constructor: ->
    yeoman.generators.Base.apply @, arguments

  prompting: ->
    done = @async()

    @prompt prompts, (answers) =>
      @config.answers = answers
      done()

  writing:
    copyBase: ->
      @src.copy '_package.json', 'package.json'

  install:
    installBower: ->
      done = @async()
      @bowerInstall @config.answers.toolsClient, { 'save': true }, done

    installGulp: ->
      done = @async()
      @npmInstall dependencies.getGulpDependencies(), { 'save-dev': true }, done

    installNpm: ->
      done = @async()
      @npmInstall @config.answers.toolsServer, { 'save': true }, done
