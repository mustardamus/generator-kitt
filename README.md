# KITT

This will be the Yeoman Generator for [starterkit](https://github.com/mustardamus/starterkit).

![](http://www.lydogbillede.dk/wp-content/uploads/2012/10/kitt.jpeg)

## TODO

  - favicon
  - express server
  - mongoose
  - gulp-clean

## Dependencies management

### gulpfile.js

The gulpfile.js will be parsed for require()'s. Found dependencies
will be installed by NPM with --save-dev flag.

Additional NPM development dependencies can be added in
dependencies.coffee (otherNpmDependencies).

### vendor.js and vendor.css

All Bower dependencies will be installed by the generator. After
installation, the vendor files (which will be joined by gulp-include)
will be automatically generated from the bower.json in each installed
Bower component.

If there is no bower.json file, or no main field in the bower.json
a error is shown. You can then overwrite the path to the main file
in dependencies.coffee (bowerDependenciesTable).
