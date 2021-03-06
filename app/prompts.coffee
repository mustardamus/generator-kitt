# note: value of choices are used to npm|bower install

module.exports = [
  {
    type:    'input'
    name:    'name'
    default: 'app'
    message: 'Name of the app (will also be used as namespace)'
  }
  {
    type:    'input'
    name:    'description'
    message: 'Short description about the app'
  }
  {
    type:    'input'
    name:    'author'
    default: 'Sebastian Senf (me@akrasia.me)'
    message: 'Who will write a magnificent piece of hackish code'
  }
  {
    type:    'input'
    name:    'license'
    default: 'MIT'
    message: 'What license will the code have'
  }
  {
    type:    'checkbox'
    name:    'toolsClient'
    message: 'Select the Client-side tools you would like to use'
    choices: [
      { checked: true,  value: 'normalize-css',        name: 'Normalize.css        - Modern CSS reset (https://necolas.github.io/normalize.css/)' }
      { checked: true,  value: 'jquery',               name: 'jQuery               - the one and only (https://jquery.com/)' }
      { checked: true,  value: 'foundation',           name: 'Foundation           - Frontend framework (http://foundation.zurb.com/)' }
      { checked: true,  value: 'fastclick',            name: 'Fastclick            - Polyfill to remove click delays on browsers with touch UIs (https://github.com/ftlabs/fastclick)' }
      { checked: true,  value: 'underscore',           name: 'Underscore           - JS Helpers (http://underscorejs.com/)' }
      { checked: true,  value: 'backbone',             name: 'Backbone             - JS framework, with Underscore and jQuery (http://backbonejs.com/)' }
      { checked: true,  value: 'handlebars',           name: 'Handlebars           - JS Templating System (http://handlebarsjs.com/)' }
      { checked: false, value: 'Backbone.dualStorage', name: 'Backbone.dualStorage - REST and localStorage Backbone adapter (https://github.com/nilbus/Backbone.dualStorage)' }
      { checked: false, value: 'modernizr',            name: 'Modernizr            - HTML5 and CSS3 features detection (http://modernizr.com/)' }
      { checked: false, value: 'fontawesome',          name: 'Font-Awesome         - Icon font (https://fortawesome.github.io/Font-Awesome/)' }
    ]
  }
  {
    type:    'checkbox'
    name:    'toolsServer'
    message: 'Select the Server-side tools you would like to use'
    choices: [
      { checked: true,  value: 'lodash',   name: 'Lodash   - JS Helpers, alternative to Underscore (http://lodash.com/)' }
      { checked: false, value: 'express',  name: 'Express  - Node.js web framework (http://expressjs.com/)' }
      { checked: false, value: 'mongoose', name: 'Mongoose - Node.js MongoDB adapter (http://mongoosejs.com/)' }
    ]
  }
]
