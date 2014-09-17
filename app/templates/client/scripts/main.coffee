{{#unless client.backbone}}
{{#if client.jquery}}
jQuery ->
  {{#if client.foundation}}
  $(document).foundation()
  {{/if}}
{{/if}}
{{#if client.nolib}}
document.addEventListener 'DOMContentLoaded', -> # http://youmightnotneedjquery.com/
{{/if}}
{{else}}
window.{{name}} =
  events: _.extend {}, Backbone.Events
  routes: require('./routers')

jQuery ->
  for routeName, routeFunc of {{name}}.routes
    {{name}}.routes[routeName] = new routeFunc

  Backbone.history.start()
  {{#if client.foundation}}
  $(document).foundation()
  {{/if}}
{{/unless}}
