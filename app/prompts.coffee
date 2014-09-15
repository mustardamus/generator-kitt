# note: value of choices are used to npm|bower install

module.exports = [
  {
    type:    'input'
    name:    'name'
    message: 'Name of the app (will be used as namespace)'
    default: 'app'
  }
  {
    type:    'checkbox'
    name:    'toolsClient'
    message: 'Select the Client-side tools you would like to use'
    choices: [
      { checked: true, value: 'zepto', name: 'Zepto - lightweight jQuery alternative (http://zeptojs.com/)' }
      { checked: false, value: 'jquery', name: 'jQuery - the one and only (https://jquery.com/)' }
      { checked: true, value: 'foundation', name: 'Foundation - Frontend framework (http://foundation.zurb.com/)' }
      { checked: true, value: 'lodash', name: 'Lodash - JS Helpers, alternative to Underscore (http://lodash.com/)' }
      { checked: true, value: 'backbone', name: 'Backbone - JS framework, with Lodash or Underscore (http://backbonejs.com/)' }
      { checked: false, value: 'Backbone.dualStorage', name: 'Backbone.dualStorage - REST and localStorage Backbone adapter (https://github.com/nilbus/Backbone.dualStorage)' }
      { checked: true, value: 'handlebars.js', name: 'Handlebars - JS Templating System (http://handlebarsjs.com/)' }
      { checked: false, value: 'modernizr', name: 'Modernizr - HTML5 and CSS3 features detection (http://modernizr.com/y)' }
    ]
  }
  {
    type:    'checkbox'
    name:    'toolsServer'
    message: 'Select the Server-side tools you would like to use'
    choices: [
      { checked: true, value: 'lodash', name: 'Lodash - JS Helpers, alternative to Underscore (http://lodash.com/)' }
      { checked: false, value: 'express', name: 'Express - Node.js web framework (http://expressjs.com/)' }
      { checked: false, value: 'mongoose', name: 'Mongoose - Node.js MongoDB adapter (http://mongoosejs.com/)' }
    ]
  }
]
