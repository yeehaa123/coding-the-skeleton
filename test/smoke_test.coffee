expect = require('chai').expect

http = require('http')

child_process = require('child_process')
child = {}

describe 'smoke test', ->

  before (done) ->
    runServer(done)

  after (done) ->
    child.on 'exit', (code, signal) ->
      console.log("Server Exited: #{code} - #{signal}")
      done()
    child.kill()

  it 'should get a response from the server when requesting homepage', (done) ->    
    httpGet 'http://localhost:9778', (response, receivedData) ->
      foundHomepage = receivedData.indexOf("Homepage") isnt -1
      expect(foundHomepage).to.be.ok
      done()

  it 'should get a 404 when requesting anything else', (done) ->    
    httpGet 'http://localhost:9778/blabla', (response, receivedData) ->
      foundHomepage = receivedData.indexOf("Page Not Found") isnt -1
      expect(foundHomepage).to.be.ok
      done()

runServer = (callback) ->
  child = child_process.spawn 'node', ['src/server/coding_the_skeleton', 9778]
  child.stdout.setEncoding('utf8')
  child.stdout.on "data", (chunk) ->
    callback() if chunk.trim() is "Server Started"

httpGet = (url, callback) ->
  request = http.get url

  request.on 'response', (response) ->
    receivedData = ""
    response.setEncoding('utf8')

    response.on 'data', (chunk) -> 
      receivedData += chunk

    response.on 'end', ->
      callback(response, receivedData)
