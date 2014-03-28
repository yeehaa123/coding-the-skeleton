server = require("../src/server/server.js")

http = require('http')
fs = require('fs')

expect = require('chai').expect


describe 'server', -> 
  PORT = 8080

  testDir  = 'generated/test'
  testFile = "#{testDir}/test.html"

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
     server.start(testFile, PORT)
     request = http.get 'http://localhost:8080'

     request.on 'response', (response) ->
       response.setEncoding('utf8')
       expect(response.statusCode).to.equal 200

       response.on 'data', (chunk) -> 
         expect(chunk).to.equal testData

       response.on 'end', ->
         server.stop ->
           done()
