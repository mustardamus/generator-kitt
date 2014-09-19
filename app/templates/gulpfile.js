var gulp        = require('gulp');
var stylus      = require('gulp-stylus');
var webserver   = require('gulp-webserver');
var browserify  = require('gulp-browserify');
var concat      = require('gulp-concat');
var include     = require('gulp-include');
var uglify      = require('gulp-uglify');
var csso        = require('gulp-csso');
var imagemin    = require('gulp-imagemin');
var prefix      = require('gulp-autoprefixer');
var browserSync = require('browser-sync');

var serverPort = 6699;
var srcDir     = './client';
var destDir    = './public';
var reload     = browserSync.reload;

gulp.task('stylus', function() {
  gulp.src(srcDir + '/styles/main.styl')
    .pipe(stylus())
    .pipe(prefix())
    .pipe(gulp.dest(destDir + '/styles/'));
});

gulp.task('vendor-css', function() {
  gulp.src(srcDir + '/styles/vendor.css')
    .pipe(include())
    .pipe(csso())
    .pipe(gulp.dest(destDir + '/styles/'));
});

gulp.task('coffee', function() {
  gulp.src(srcDir + '/scripts/main.coffee', { read: false })
    .pipe(browserify({
      transform: ['coffeeify'],
      extensions: ['.coffee']
    }))
    .pipe(concat('main.js'))
    .pipe(gulp.dest(destDir + '/scripts/'));
});

gulp.task('vendor-js', function() {
  gulp.src(srcDir + '/scripts/vendor.js')
    .pipe(include())
    .pipe(uglify())
    .pipe(gulp.dest(destDir + '/scripts/'));
});

gulp.task('copy-html', function() {
  gulp.src(srcDir + '/*.html')
    .pipe(gulp.dest(destDir + '/'));
});

{{#if client.fontawesome}}
gulp.task('copy-fonts', function() {
  gulp.src(srcDir + '/bower_components/fontawesome/fonts/*')
    .pipe(gulp.dest(destDir + '/fonts/'));
});

{{/if}}
gulp.task('copy-images', function() {
  gulp.src(srcDir + '/images/**')
    .pipe(imagemin())
    .pipe(gulp.dest(destDir + '/images/'));
});

gulp.task('build', [
  'copy-html', 'stylus', 'coffee', 'vendor-js',
  'vendor-css', {{#if client.fontawesome}}'copy-fonts', {{/if}}'copy-images'
]);

gulp.task('watch', function() {
  gulp.watch(srcDir + '/*.html',              ['copy-html', reload]);
  gulp.watch(srcDir + '/styles/**/*.styl',    ['stylus', reload]);
  gulp.watch(srcDir + '/styles/vendor.css',   ['vendor-css', reload]);
  gulp.watch(srcDir + '/scripts/**/*.coffee', ['coffee', reload]);
  gulp.watch(srcDir + '/scripts/vendor.js',   ['vendor-js', reload]);
  gulp.watch(srcDir + '/images/**/*',         ['copy-images', reload]);
});

gulp.task('server', ['build', 'watch'], function() {
  browserSync({
    server: { baseDir: destDir },
    port:   serverPort,
    open:   false,
    notify: false
  });
});

gulp.task('default', ['build']);
