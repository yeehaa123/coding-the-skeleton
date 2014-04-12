chai = require('chai')
chaiAsPromised = require('chai-as-promised')

chai.use(chaiAsPromised)
expect = chai.expect

describe 'index page', ->
  it 'has the right title', ->
    browser.get('/#')
    expect(browser.getTitle()).to.eventually.equal "Hello World"
