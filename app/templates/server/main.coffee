config = require('./config')
{{#if server.lodash}}
lodash = require('lodash')
{{/if}}
{{#unless server.express}}

module.exports = ->
  console.log config.welcome
{{else}}
express    = require('express')
bodyParser = require('body-parser')
fs         = require('fs')
{{#if server.mongoose}}
mongoose   = require('mongoose')
{{/if}}

initDir = (path) ->
  outObj   = {}
  filesArr = fs.readdirSync(path)

  for fileName in filesArr
    funcs = require("#{path}/#{fileName}")
    name  = fileName.split('.')[0]

    if funcs and name
      outObj[name] = funcs
      shortPath    = path.split('/')
      console.log "Initialized '#{shortPath[shortPath.length - 1]}/#{fileName}'"

  outObj

app       = express()
helpers   = initDir(config.server.helpersDir)
{{#if server.lodash}}
helpers._ = lodash
{{/if}}
routes    = initDir(config.server.routesDir)
{{#if server.mongoose}}
models    = initDir(config.server.modelsDir)
db        = mongoose.connection
{{/if}}

for resourceName, modelFunc of models
  models[resourceName] = modelFunc.call(mongoose, helpers)

{{#if server.mongoose}}
for resourceName, routesFunc of routes
  routesFunc.call(app, models, helpers, config)

{{/if}}
app.use express.static(config.server.publicDir)
app.use bodyParser.json()

app.listen(config.server.port)
console.log "Webserver started on port #{config.server.port}..."

{{#if server.mongoose}}
db.once 'open', ->
  console.log "Connect to database #{config.database.url}"

db.on 'error', ->
  console.log "Oops, can not connect to database #{config.database.url}"

mongoose.connect config.database.url
{{/if}}
{{/unless}}
