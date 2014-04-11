chai = require('chai')
chaiAsPromised = require('chai-as-promised')

chai.use(chaiAsPromised)
expect = chai.expect

describe 'index page', ->
  ptor = protractor.getInstance()

  it 'has the right title', ->
    ptor.get('/#')
    
