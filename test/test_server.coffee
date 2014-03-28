server = require("../src/server/server.js")

http = require('http')
fs = require('fs')
PORT = 8080

testDir  = 'generated/test'
testFile = "#{testDir}/test.html"

expect = require('chai').expect


describe 'server', -> 

  describe 'basic functionality', (done) ->

    it 'should throw an exception if port is not specified', (done) ->
      expect(-> server.start(testFile)).to.throw(/Port number is not specified/)
      done()

    it 'should throw an exception if stop is called twice', (done) ->
       server.start(testFile, PORT)
       server.stop()
       expect(-> server.stop()).to.throw(/Not running/)
       done()

    it 'should throw an exception if file to serve is not specified', (done) ->
      expect(-> server.start(null, PORT)).to.throw(/HTML file to serve is not specified/)
      done()

    it 'should return a 404 for everything but homepage', (done) ->
      httpGet 'http://localhost:8080/blabla', (response, responseData) ->
        expect(response.statusCode).to.equal 404
        done()

  describe 'static file serving', ->
    testData = "Hello World"

    before (done) ->
     fs.writeFileSync(testFile, testData)
     expect(fs.existsSync(testFile)).to.be.ok
     done()

    after (done) ->
      fs.unlinkSync(testFile)
      expect(!fs.existsSync(testFile)).to.be.ok
      done()

    it 'should serve a file', (done) ->
      httpGet 'http://localhost:8080', (response, responseData) ->
        expect(response.statusCode).to.equal 200
        expect(responseData).to.equal testData
        done()


httpGet = (url, callback) ->
  server.start(testFile, PORT);
  request = http.get url

  request.on 'response', (response) ->
    receivedData = ""
    response.setEncoding('utf8')

    response.on 'data', (chunk) -> 
      receivedData += chunk

    response.on 'end', ->
      server.stop ->
        callback(response, receivedData)
