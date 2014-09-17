fs = require('fs')
_  = require('lodash')

module.exports =
  getGulpDependencies: -> # parse gulpfile for dependencies
    content = fs.readFileSync "#{__dirname}/templates/gulpfile.js", 'utf-8'
    lines   = content.split('\n')
    deps    = []

    for line in lines
      reqArr = line.split('require(')

      if reqArr.length is 2
        dep = reqArr[1].split(')')[0].split("'").join('')
        deps.push dep if dep.length

    deps

  otherNpmDependencies: [ # dependencies needed but not required in gulpfile
    'coffee-script', 'coffeeify'
  ]

  getBowerDependencies: (tools, bowerDir, prefix) ->
    output = { scripts: [], styles: [], unknown: [] }

    for tool in tools
      toolDir = "#{bowerDir}/#{tool}"

      if fs.existsSync(toolDir)
        bowerFile = "#{toolDir}/bower.json"

        unless fs.existsSync(bowerFile)
          output.unknown.push toolDir
          continue

        config    = JSON.parse(fs.readFileSync(bowerFile, 'utf-8'))
        mainFiles = if _.isArray(config.main) then config.main else [config.main]

        for file in mainFiles
          extension = _.last(file.split('.')).toLowerCase()
          filePath  = "#{prefix}/#{tool}/#{file}"

          output.scripts.push filePath if extension is 'js'
          output.styles.push filePath if extension is 'css'

    output
