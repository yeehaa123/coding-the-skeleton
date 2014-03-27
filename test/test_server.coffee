server = require("../src/server/server.js")
http = require('http')

expect = require('chai').expect


describe 'server', -> 
  PORT = 8080

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
