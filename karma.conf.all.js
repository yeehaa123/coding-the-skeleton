// Karma configuration
// Generated on Sat Mar 29 2014 18:50:49 GMT-0400 (EDT)

console.log(__dirname);
module.exports = function(config) {
  config.set({
    frameworks: ['mocha', 'chai'],
    files: [
    //   'test/client/**/*_test.coffee'
    ],
    preprocessors: {
      '**/*.coffee': ['coffee']
    },
    reporters: ['dots'],
    port: 9876,
    browsers: [
      'PhantomJS', 
      'Chrome',
      'Firefox'
    ],
    plugins: [
      'karma-mocha',
      'karma-chai',
      'karma-coffee-preprocessor',
      'karma-chrome-launcher',
      'karma-phantomjs-launcher',
      'karma-firefox-launcher'
    ]
  });
};
