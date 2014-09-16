var gulp       = require('gulp');
var gutil      = require('gulp-util');
var stylus     = require('gulp-stylus');
var webserver  = require('gulp-webserver');
var browserify = require('gulp-browserify');
var concat     = require('gulp-concat');
var include    = require('gulp-include');
var uglify     = require('gulp-uglify');
var csso       = require('gulp-csso');
var imagemin   = require('gulp-imagemin');
var prefix     = require('gulp-autoprefixer');
var coffeeify  = require('coffeeify');

var serverPort     = 6699;
var livereloadPort = 36699;

gulp.task('stylus', function() {
  gulp
    .src('./app/styles/*.styl')
    .pipe(stylus())
    .pipe(prefix())
    .pipe(gulp.dest('./public/styles/'));
});

gulp.task('vendor-css', function() {
  gulp
    .src('./app/styles/vendor.css')
    .pipe(include())
    .pipe(csso())
    .pipe(gulp.dest('./public/styles/'));
});

gulp.task('coffee', function() {
  gulp
    .src('./app/scripts/main.coffee', { read: false })
    .pipe(browserify({
      transform: ['coffeeify'],
      extensions: ['.coffee']
    }))
    .pipe(concat('main.js'))
    .pipe(gulp.dest('./public/scripts/'));
});

gulp.task('vendor-js', function() {
  gulp
    .src('./app/scripts/vendor.js')
    .pipe(include())
    .pipe(uglify())
    .pipe(gulp.dest('./public/scripts/'));

  gulp
    .src('./app/bower_components/modernizr/modernizr.js')
    .pipe(uglify())
    .pipe(gulp.dest('./public/scripts'));
});

gulp.task('copy-html', function() {
  gulp
    .src('./app/*.html')
    .pipe(gulp.dest('./public/'));
});

gulp.task('copy-fonts', function() {
  gulp
    .src('./app/bower_components/fontawesome/fonts/*')
    .pipe(gulp.dest('./public/fonts/'));
});

gulp.task('copy-images', function() {
  gulp
    .src('./app/images/**')
    .pipe(imagemin())
    .pipe(gulp.dest('./public/images/'));
});

gulp.task('build',
  [
    'copy-html',
    'stylus',
    'coffee',
    'vendor-js',
    'vendor-css',
    'copy-fonts',
    'copy-images'
  ]
);

gulp.task('watch', function() {
  gulp.watch('./app/*.html', ['copy-html']);
  gulp.watch('./app/styles/*.styl', ['stylus']);
  gulp.watch('./app/styles/vendor.css', ['vendor-css']);
  gulp.watch('./app/scripts/**/*.coffee', ['coffee']);
  gulp.watch('./app/scripts/vendor.js', ['vendor-js']);
  gulp.watch('./app/images/*', ['copy-images']);
});

gulp.task('server', ['build', 'watch'], function() {
  gulp
    .src('./public')
    .pipe(webserver({
      port: serverPort,
      livereload: {
        enabled: true,
        port: livereloadPort
      }
    }));
});

gulp.task('default', ['build']);
