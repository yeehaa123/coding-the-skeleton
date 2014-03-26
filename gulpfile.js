var gulp   = require('gulp');
var sass   = require('gulp-sass');
var jshint = require('gulp-jshint');
var clean  = require('gulp-clean');

var paths = {
  sass: './src/styles/main.scss',
  js: './src/**/*.js'
}

gulp.task('clean', function(){
  gulp.src(['./dev', './dist'], {read: false})
      .pipe(clean());
});

gulp.task('lint', function(){
  gulp.src(paths.js)
      .pipe(jshint())
      .pipe(jshint.reporter('default'));
});

gulp.task('generateCss', function(){
  gulp.src(paths.sass)
      .pipe(sass())
      .pipe(gulp.dest('./dev/styles'))
      .pipe(gulp.dest('./dist/styles'));
});

gulp.task('watch', function(){
  gulp.watch(paths.sass, ['generateCss']);
  gulp.watch(paths.js, ['lint']);
});

gulp.task('default', ['generateCss', 'lint', 'watch']);
gulp.task('test', ['generateCss', 'lint']);
