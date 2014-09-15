yeoman  = require('yeoman-generator')
prompts = require('./prompts')

module.exports = yeoman.generators.Base.extend
  constructor: ->
    yeoman.generators.Base.apply @, arguments

  prompting: ->
    done = @async()

    @prompt prompts, (answers) =>
      @config.answers = answers
      done()

  install:
    installBower: ->
      done = @async()
      @bowerInstall @config.answers.toolsClient, { 'save': true }, done

    installNpm: ->
      done = @async()
      @npmInstall @config.answers.toolsServer, { 'save': true }, done
