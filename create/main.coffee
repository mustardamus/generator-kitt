yeoman     = require('yeoman-generator')
pluralize  = require('pluralize')
Handlebars = require('handlebars')

module.exports = yeoman.generators.Base.extend
  prompting:
    resourceName: ->
      done = @async()

      @prompt
        type:    'input'
        name:    'name',
        message: 'Resource Name (lowercase, singular, one word)'
      , (answers) =>
        @config.resourceName       = answers.name
        @config.resourceNamePlural = pluralize(answers.name)
        done()

    backbone: ->
      if @dest.exists('client/scripts/collections')
        done          = @async()
        resName       = @config.resourceName
        resNamePlural = @config.resourceNamePlural

        @prompt
          type:    'checkbox'
          name:    'backbone',
          message: 'Select which Backbone resources you like to create (in client/scripts)'
          choices: [
            { checked: true, value: 'route',      name: "Route (routes/#{resNamePlural}.coffee) (+ entry in routes.coffee)" }
            { checked: true, value: 'collection', name: "Collection (collections/#{resNamePlural}.coffee)" }
            { checked: true, value: 'model',      name: "Model (models/#{resName}.coffee)" }
            { checked: true, value: 'viewList',   name: "List View (views/#{resNamePlural}/list.coffee)" }
            { checked: true, value: 'viewItem',   name: "Item View (views/#{resNamePlural}/item.coffee)" }
          ]
        , (answers) =>
          @config.backbone = {}

          for answer in answers.backbone
            @config.backbone[answer] = true

          done()

  writing:
    backbone: ->
      return unless @config.backbone

      resName       = @config.resourceName
      resNamePlural = @config.resourceNamePlural

      if @config.backbone.route
        routersPath = 'client/scripts/routers.coffee'
        content     = @dest.read(routersPath)
        contentArr  = content.split('\n')

        if contentArr[contentArr.length - 1].length is 0
          contentArr.pop()

        contentArr.push "  #{resName}: require('./routers/#{resNamePlural}')"
        @dest.write routersPath, contentArr.join('\n')

        template = Handlebars.compile(@src.read('client/router.coffee'))
        @dest.write "client/scripts/routers/#{resNamePlural}.coffee", template(@config)

      if @config.backbone.collection
        template = Handlebars.compile(@src.read('client/collection.coffee'))
        @dest.write "client/scripts/collections/#{resNamePlural}.coffee", template(@config)

      if @config.backbone.model
        @src.copy 'client/model.coffee', "client/scripts/models/#{resName}.coffee"

      if @config.backbone.viewList
        template = Handlebars.compile(@src.read('client/viewList.coffee'))
        @dest.write "client/scripts/views/#{resNamePlural}/list.coffee", template(@config)

      if @config.backbone.viewItem
        template = Handlebars.compile(@src.read('client/viewItem.coffee'))
        @dest.write "client/scripts/views/#{resNamePlural}/item.coffee", template(@config)

        @src.copy 'client/template.coffee', "client/scripts/templates/#{resNamePlural}/item.coffee"
