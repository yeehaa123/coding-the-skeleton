exports.config = {
  specs: [
    './e2e/**/*.spec.coffee'
  ],
  // The address of a running selenium server.
  seleniumServerJar: '../node_modules/protractor/selenium/selenium-server-standalone-2.40.0.jar',
  //seleniumAddress: 'http://localhost:4444/wd/hub',

  framework: 'mocha',

  baseUrl: 'http://localhost:3000',

  plugins: [
    'protractor-coffee-preprocessor'
  ],

  // Capabilities to be passed to the webdriver instance.
  capabilities: {
    'browserName': 'chrome'
  },

  // Options to be passed to Jasmine-node.
};
