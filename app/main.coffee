yeoman  = require('yeoman-generator')
prompts = require('./prompts')

module.exports = yeoman.generators.Base.extend
  constructor: ->
    yeoman.generators.Base.apply @, arguments

  prompting: ->
    @prompt prompts, (answers) ->
      console.log answers
