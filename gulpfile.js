'use strict'

var gulp   = require('gulp');
var sass   = require('gulp-sass');
var jshint = require('gulp-jshint');
var clean  = require('gulp-clean');
var mocha  = require('gulp-mocha');
var stylish = require('jshint-stylish'); 

var paths = {
  sass: './src/styles/main.scss',
  js: { 
    all: ['./src/app/**/*.js','./src/server/**/*.js'],
    client: './src/app/**/*.js',
    server: './src/server/**/*.js'
  },
  tests: {
    server: './test/**/*.coffee',
  }
}

gulp.task('clean', function(){
  return gulp.src(['./build'], {read: false})
      .pipe(clean());
});

gulp.task('lintJS', function(){
  return gulp.src(paths.js.all)
      .pipe(jshint('.jshintrc'))
      .pipe(jshint.reporter(stylish))
});

gulp.task('testServer', function(){
  require('coffee-script/register');
  return gulp.src(paths.tests.server)
             .pipe(mocha({reporter: 'list'}));
});

gulp.task('generateCSS', function(){
  return gulp.src(paths.sass)
      .pipe(sass())
      .pipe(gulp.dest('./build/styles'))
});

gulp.task('watch', function(){
  gulp.watch(paths.sass, ['generateCSS']);
  gulp.watch(paths.js.all, ['lintJS']);
  gulp.watch(paths.tests.coffee, ['testServer']);
});

gulp.task('default', ['generateCSS', 'lintJS', 'testServer', 'watch']);
gulp.task('test', ['generateCSS', 'lintJS', 'testServer'])
