var gulp   = require('gulp');
var sass   = require('gulp-sass');
var jshint = require('gulp-jshint');
var clean  = require('gulp-clean');

var paths = {
  sass: './src/styles/main.scss',
  js: './src/**/*.js'
}

gulp.task('clean', function(){
  gulp.src(['./build'], {read: false})
      .pipe(clean());
});

gulp.task('lintJS', function(){
  gulp.src(paths.js)
      .pipe(jshint())
      .pipe(jshint.reporter('default'));
});

gulp.task('generateCSS', function(){
  gulp.src(paths.sass)
      .pipe(sass())
      .pipe(gulp.dest('./build/styles'))
});

gulp.task('watch', function(){
  gulp.watch(paths.sass, ['generateCSS']);
  gulp.watch(paths.js, ['lint']);
});

gulp.task('default', ['generateCSS', 'lintJS', 'watch']);
gulp.task('test', ['generateCSS', 'lintJS']);
