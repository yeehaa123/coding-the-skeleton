expect = require('chai').expect
helpers = require('./helpers/test_helpers')
httpGet = helpers.httpGet

describe 'release test', ->
  it 'should get a response from the server when requesting homepage', (done) ->    
    @timeout(5001)
    httpGet 'http://skeleton-test.herokuapp.com', (response, receivedData) ->
      foundHomepage = receivedData.indexOf("Homepage") isnt -1
      expect(foundHomepage).to.be.ok
      done()

