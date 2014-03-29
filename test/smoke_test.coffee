expect = require('chai').expect
helpers = require('./helpers/test_helpers')
httpGet = helpers.httpGet
runServer = helpers.runServer
killServer = helpers.killServer
parseProcFile = helpers.parseProcFile

describe 'smoke test', ->
  params = parseProcFile('Procfile')
  port   = params.options[1]

  before (done) ->
    runServer(params, done)

  after (done) ->
    killServer(done)

  it 'should get a response from the server when requesting homepage', (done) ->    
    httpGet 'http://localhost:' + port, (response, receivedData) ->
      foundHomepage = receivedData.indexOf("Homepage") isnt -1
      expect(foundHomepage).to.be.ok
      done()

  it 'should get a 404 when requesting anything else', (done) ->    
    httpGet 'http://localhost:' + port + '/blabla', (response, receivedData) ->
      found404page = receivedData.indexOf("Page Not Found") isnt -1
      expect(found404page).to.be.ok
      done()
