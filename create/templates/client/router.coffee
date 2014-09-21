{{#if backbone.collection}}
Collection = require('../collections/{{resourceNamePlural}}')
{{/if}}
{{#if backbone.viewList}}
ListView   = require('../views/{{resourceNamePlural}}/list')
{{/if}}

module.exports = Backbone.Router.extend
  routes:
    '{{resourceNamePlural}}': 'onRoot'

  initialize: ->
    _.bindAll @, 'onRoot'

    {{#if backbone.collection}}
    @collection = new Collection

    {{/if}}
    {{#if backbone.viewList}}
    @listView = new ListView
      collection: @collection
      el:         '#{{resourceNamePlural}}-list'
    {{/if}}

  onRoot: ->
    console.log '{{resourceNamePlural}} router ready'
