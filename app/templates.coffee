fs         = require('fs')
Handlebars = require('handlebars')

module.exports =
  baseTemplates: [
    { fileIn: '_package.json', fileOut: 'package.json' }
    { fileIn: '_bower.json', fileOut: 'bower.json' }
    { fileIn: 'bowerrc', fileOut: '.bowerrc' }
    { fileIn: 'editorconfig', fileOut: '.editorconfig' }
    { fileIn: 'gitignore', fileOut: '.gitignore' }
    { fileIn: 'gulpfile.js' } # if no fileOut then use same filename
    { fileIn: 'README.md' }
    { fileIn: 'client/index.html' }
    { fileIn: 'client/scripts/main.coffee' }
    { fileIn: 'client/styles/main.styl' }
    { fileIn: 'client/styles/common.styl' }
    { fileIn: 'client/styles/mobile.styl' }
    { fileIn: 'client/styles/tablet.styl' }
    { fileIn: 'client/styles/desktop.styl' }
  ]

  serverTemplates: [
    { fileIn: 'server/config.coffee' }
    { fileIn: 'server/main.coffee' }
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
