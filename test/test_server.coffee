server = require("../src/server/server.js")

http = require('http')
fs = require('fs')

expect = require('chai').expect


describe 'server', -> 
  PORT = 8080

  describe 'basic functionality', ->

    it 'should return hello world', (done)->
      server.start(PORT)

      request = http.get 'http://localhost:8080'

      request.on 'response', (response) ->
        response.setEncoding('utf8')
        expect(response.statusCode).to.equal 200

        response.on 'data', (chunk) -> 
          expect(chunk).to.equal "Hello World"

        response.on 'end', ->
          server.stop ->
            done()

    it 'should run a callback after it stops', (done) ->
      server.start(PORT)
      server.stop ->
        done()

    it 'should throw an exception if port is not specified', (done) ->
      expect(-> server.start()).to.throw(/Port number is not specified/)
      done()


    it 'should throw an exception if stop is called twice', (done) ->
       server.start(PORT)
       server.stop()
       expect(-> server.stop()).to.throw(/Not running/)
       done()

   describe 'file serving', ->
     it 'should serve a file', (done) ->
       testDir  = 'generated/test'
       testFile = "#{testDir}/test.html"

       try 
         fs.writeFileSync(testFile, 'Hello World')
         done()
       finally
         fs.unlinkSync(testFile)
         expect(!fs.existsSync(testFile)).to.equal(true)
