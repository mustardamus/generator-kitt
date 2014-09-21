module.exports = (models, _, config) ->
  @get '/hello/:name', (req, res) ->
    res.json { str: _.{{resourceNamePlural}}.sayHello(req.params.name) }
