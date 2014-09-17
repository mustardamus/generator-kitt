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

  bowerDependenciesTable: # if a package has no bower.json, set path with this table
    'modernizr': 'modernizr.js'

  getBowerDependencies: (tools, bowerDir, prefix) ->
    output = { scripts: [], styles: [], missing: [], unknown: [] }

    for tool in tools
      toolDir = "#{bowerDir}/#{tool}"

      unless fs.existsSync(toolDir)
        output.missing.push toolDir
      else
        bowerFile = "#{toolDir}/bower.json"
        config    = {}
        valid     = true

        if @bowerDependenciesTable[tool]
          config.main = @bowerDependenciesTable[tool]
        else
          unless fs.existsSync(bowerFile)
            output.missing.push toolDir
            valid = false
          else
            config = JSON.parse(fs.readFileSync(bowerFile, 'utf-8'))

            unless config.main
              output.unknown.push toolDir
              valid = false

        continue unless valid

        mainFiles = if _.isArray(config.main) then config.main else [config.main]

        for file in mainFiles
          extension = _.last(file.split('.')).toLowerCase()
          filePath  = "#{prefix}/#{tool}/#{file}"

          output.scripts.push filePath if extension is 'js'
          output.styles.push filePath if extension is 'css'

    output
