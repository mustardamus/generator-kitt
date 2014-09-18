module.exports =
{{#unless server.express}}
  welcome: 'ello'
{{/unless}}
{{#if server.express}}
  server:
    port      : 7799
    publicDir : "#{__dirname}/../public"
    helpersDir: "#{__dirname}/helpers"
    routesDir : "#{__dirname}/routes"
    {{#if server.mongoose}}
    modelsDir : "#{__dirname}/models"
    {{/if}}

{{/if}}
{{#if server.mongoose}}
  database:
    url: 'mongodb://localhost/{{name}}'
{{/if}}
