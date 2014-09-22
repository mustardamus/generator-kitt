# KITT Yeoman Generator

A sweet and simple web project generator and scaffolder tailored to my current
flavor of tools. Including Gulp, Browserify, CoffeeScript, Stylus, Foundation,
Express, Mongoose and other fancy stuff.

![Michael says YEAH](https://camo.githubusercontent.com/ccf80af2c8ba0cc071e3e4a10437bb08b811ec21/687474703a2f2f7777772e6c79646f6762696c6c6564652e646b2f77702d636f6e74656e742f75706c6f6164732f323031322f31302f6b6974742e6a706567)

## Installation

This is a work in progress and is likely to be changing while starting 100 new
projects. It's currently not published to NPM. You can use it anyway if you
think this sounds like a environment you'd like to work in.

    git clone git@github.com:mustardamus/generator-kitt.git
    cd generator-kitt
    npm link

## Usage

Easy as talking to KITT:

    mkdir project
    cd project
    yo kitt

You are then prompted with a couple of questions and can select client- and
server-side tools you'd like to use.

## Features

### Base Tools

Gulp, Browserify, CoffeeScript and Stylus.
No matter what additional tools you want, this is the base for all of them.

### Client Tools

### Server Tools

## Extras

### `gulpfile.js`

The `gulpfile.js` will be parsed for `require()`'s. Found dependencies will be
installed by NPM with --save-dev flag.

Additional development dependencies that are not required by the `gulpfile.js`,
can be added in `dependencies.coffee`.

### `vendor.js` and `vendor.css`

After all Bower dependencies are installed ans saved to `bower.json`, the
asset entry points `vendor.js` and `vendor.css` will be automatically built.

Depending on what tools the user selected, the folder `client/bower_components`
will be scanned for `bower.json` files. If found, it checks for the `main` field
and if found, include it in `client/scripts/vendor.js` if it is a `.js` file,
and in `client/styles/vendor.css` if it is a `.css` file.

If there is no `bower.json` file in the dependency, or a `main` field is missing,
it spits out a error message. You can then find the dependent files and include
it by hand.
