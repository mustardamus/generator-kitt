{{#unless client.backbone}}
{{#if client.jquery}}
jQuery ->
{{/if}}
{{#if client.zepto}}
Zepto ->
{{/if}}
{{#if client.nolib}}
document.addEventListener 'DOMContentLoaded', ->
{{/if}}
  {{#if client.foundation}}
  $(document).foundation()
  {{/if}}
{{else}}
window.{{name}} =
  events: _.extend {}, Backbone.Events
  routes: require('./routers')

{{#if client.jquery}}
jQuery ->
{{/if}}
{{#if client.zepto}}
Zepto ->
{{/if}}
  for routeName, routeFunc of {{name}}.routes
    {{name}}.routes[routeName] = new routeFunc

  Backbone.history.start()
  {{#if client.foundation}}
  $(document).foundation()
  {{/if}}
{{/unless}}
