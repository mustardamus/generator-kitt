fs = require('fs')

module.exports =
  # this function reads all dependencies declared in the gulpfile
  # they must be in the format of (note the single '). hackery at its finest.
  #   var gulp = require('gulp');

  getGulpDependencies: ->
    content = fs.readFileSync "#{__dirname}/templates/gulpfile.js", 'utf-8'
    lines   = content.split('\n')
    deps    = []

    for line in lines
      reqArr = line.split('require(')

      if reqArr.length is 2
        dep = reqArr[1].split(')')[0].split("'").join('')
        deps.push dep if dep.length

    deps
