'use strict'

var fs      = require('fs');
var mkdirp  = require('mkdirp');
var rimraf  = require('rimraf');

var gulp    = require('gulp');
var sass    = require('gulp-sass');
var jshint  = require('gulp-jshint');
var clean   = require('gulp-clean');
var mocha   = require('gulp-mocha');
var karma   = require('gulp-karma');
var stylish = require('jshint-stylish'); 
var batch   = require('gulp-batch'); 

var watching = false;

var paths = {
  sass: './src/styles/main.scss',
  js: { 
    all: ['./src/app/**/*.js','./src/server/**/*.js'],
    client: './src/app/**/*.js',
    server: './src/server/**/*.js'
  },
  tests: {
    server: './test/server/**/*_test.coffee',
    client: './test/client/**/*_test.coffee',
  }
}

gulp.task('clean', function(){
  return gulp.src(['./build', './generated'], {read: false})
      .pipe(clean());
});

gulp.task('lintJS', function(){
  return gulp.src(paths.js.all)
      .pipe(jshint('.jshintrc'))
      .pipe(jshint.reporter(stylish))
});

gulp.task('testServer', ['createTestDir'], function(){
  require('coffee-script/register');
  return gulp.src(paths.tests.server)
             .pipe(mocha({
               reporter: 'spec',
              }))
             .on('error', onError);
});

gulp.task('testClientOnce', function() {
  return gulp.src(paths.tests.client)
    .pipe(karma({
      configFile: 'karma.conf.js',
      action: 'run'
    }))
    .on('error', function(err) {
      // Make sure failed tests cause gulp to exit non-zero
      throw err;
    });
});

gulp.task('testClient', function() {
  return gulp.src(paths.tests.client)
    .pipe(karma({
      configFile: 'karma.conf.js',
      action: 'watch'
    }));
});

gulp.task('generateCSS', function(){
  return gulp.src(paths.sass)
      .pipe(sass())
      .pipe(gulp.dest('./build/styles'))
});

gulp.task('createTestDir', function(){
  if (fs.existsSync('./generated/test')){
    rimraf.sync('./generated/test');
  };
  mkdirp.sync('./generated/test');
});

gulp.task('watch', function(){
  watching = true;
  gulp.watch(paths.sass, ['generateCSS']);
  gulp.watch(paths.js.all, ['lintJS', 'testServer']);
  gulp.watch(paths.tests.server, ['testServer']);
});


function onError(err) {
  console.log(err.toString());
  if (watching) {
    this.emit('end');
  }
}

gulp.task('integrate', ['test'], function(){
  console.log("1. Make sure 'git status' is clean.");
  console.log("2. Build on the integration box.");
  console.log("   a. 'git push'");
  console.log("   c. 'heroku addons:open werker'");
  console.log("   d. If wercker fails, stop! Try again after fixing the issue.");
  console.log("3. 'git checkout integration'");
  console.log("4. 'git merge master --no-ff --log'");
  console.log("5. 'git checkout master'");
});

gulp.task('deploy', ['test'], function(){
  console.log("1. Make sure 'git status' is clean.");
  console.log("2. git push heroku master");
  console.log("3. Test the release");
})

gulp.task('standard', ['generateCSS', 'lintJS', 'testServer']);
gulp.task('test', ['standard', 'testClientOnce']);
gulp.task('default', ['standard', 'testClient', 'watch']);
