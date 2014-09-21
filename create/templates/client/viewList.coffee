{{#if backbone.viewItem}}
ItemView = require('./item')

{{/if}}
module.exports = Backbone.View.extend
  tagName: 'ul'
  events: {}

  initialize: ->
    _.bindAll @, 'render'

    @collection.on 'reset', @render

  render: ->
    for model in @collection.models
      {{#if backbone.viewItem}}
      itemView = new ItemView({ model: model })

      @$el.append itemView.render()
      {{else}}
      console.log '{{resourceName}} model', model
      {{/if}}

    @$el
