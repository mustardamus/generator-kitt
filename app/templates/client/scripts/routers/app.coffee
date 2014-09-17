LayoutView = require('../views/layout/layout')

module.exports = Backbone.Router.extend
  routes:
    '': 'onRoot'

  initialize: ->
    _.bindAll @, 'onRoot'

    @layoutView = new LayoutView

  onRoot: ->
