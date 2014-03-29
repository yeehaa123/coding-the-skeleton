expect = require('chai').expect
helpers = require('./helpers/test_helpers')
httpGet = helpers.httpGet
runServer = helpers.runServer
killServer = helpers.killServer

describe 'smoke test', ->

  before (done) ->
    runServer(done)

  after (done) ->
    killServer(done)

  it 'should get a response from the server when requesting homepage', (done) ->    
    httpGet 'http://localhost:8080', (response, receivedData) ->
      foundHomepage = receivedData.indexOf("Homepage") isnt -1
      expect(foundHomepage).to.be.ok
      done()

  it 'should get a 404 when requesting anything else', (done) ->    
    httpGet 'http://localhost:8080/blabla', (response, receivedData) ->
      found404page = receivedData.indexOf("Page Not Found") isnt -1
      expect(found404page).to.be.ok
      done()
