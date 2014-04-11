exports.config = {
  specs: [
    './e2e/**/*.spec.coffee'
  ],
  // The address of a running selenium server.
  seleniumServerJar: '../node_modules/protractor/selenium/selenium-server-standalone-2.40.0.jar',
  //seleniumAddress: 'http://localhost:4444/wd/hub',
  framework: 'mocha',
  plugins: [
    'protractor-coffee-preprocessor'
  ],

  // Capabilities to be passed to the webdriver instance.
  capabilities: {
    'browserName': 'phantom'
  },

  // Options to be passed to Jasmine-node.
};
