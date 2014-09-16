fs         = require('fs')
Handlebars = require('handlebars')

module.exports =
  baseTemplates: [
    { fileIn: '_package.json', fileOut: 'package.json' }
    { fileIn: 'gulpfile.js' } # if no fileOut then use same filename
  ]

  compile: (files, config) ->
    outFiles = []

    for file in files
      file.fileOut = file.fileIn unless file.fileOut
      content      = fs.readFileSync("#{__dirname}/templates/#{file.fileIn}", 'utf-8')
      template     = Handlebars.compile(content)
      file.content = template(config)

      outFiles.push file

    outFiles

module.exports.compile(module.exports.baseTemplates, { name: 'yuhaaa' })
