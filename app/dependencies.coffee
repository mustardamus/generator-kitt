fs = require('fs')

module.exports =
  scriptVendorMap: # path to bower_components will be built
    'jquery':     'jquery/dist/jquery.js'
    'foundation': 'foundation/js/foundation.js'
    
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
