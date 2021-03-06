// Karma configuration
// Generated on Sat Mar 29 2014 18:50:49 GMT-0400 (EDT)

module.exports = function(config) {
  config.set({
    frameworks: ['mocha', 'chai'],
    files: [
    //   'test/client/**/*_test.coffee'
    ],
    preprocessors: {
      '**/*.coffee': ['coffee']
    },
    reporters: ['progress', 'coverage'],
    port: 9876,
    browsers: ['PhantomJS'],
    plugins: [
      'karma-mocha',
      'karma-chai',
      'karma-coffee-preprocessor',
      'karma-phantomjs-launcher',
      'karma-coverage'
    ]
  });
};
