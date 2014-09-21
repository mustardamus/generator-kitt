module.exports = Backbone.View.extend
  template: require('../../templates/{{resourceNamePlural}}/item')
  tagName: 'li'
  events: {}

  initialize: ->
    _.bindAll @, 'render'

    @model.on 'change', @render

  render: ->
    template = Handlebars.compile(@template)

    @$el.html template(@model.toJSON())
