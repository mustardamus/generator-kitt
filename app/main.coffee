yeoman       = require('yeoman-generator')
prompts      = require('./prompts')
dependencies = require('./dependencies')
templates    = require('./templates')

module.exports = yeoman.generators.Base.extend
  prompting: ->
    done = @async()

    @prompt prompts, (answers) =>
      @config.answers = answers
      done()

  writing:
    copyBase: ->
      files = templates.compile(templates.baseTemplates, @config.answers)

      for file in files
        @dest.write file.fileOut, file.content

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
