module.exports = Backbone.Collection.extend
  {{#if backbone.model}}
  model: require('../models/{{resourceName}}')

  {{/if}}
  initialize: ->
