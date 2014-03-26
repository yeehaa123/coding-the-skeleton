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
    server: './src/server/**/*.js',
    tests: './test/**/*.js'
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
      .pipe(jshint.reporter('fail'));
});

gulp.task('testJS', function(){
  return gulp.src([paths.js.test], {read: false})
      .pipe(mocha({reporter: 'nyan'}));
});

gulp.task('generateCSS', function(){
  return gulp.src(paths.sass)
      .pipe(sass())
      .pipe(gulp.dest('./build/styles'))
});

gulp.task('watch', function(){
  gulp.watch(paths.sass, ['generateCSS']);
  gulp.watch(paths.js.all, ['lintJS']);
});

gulp.task('default', ['generateCSS', 'lintJS', 'testJS', 'watch']);
gulp.task('test', ['generateCSS', 'lintJS']);
