PORT = 8080

server = require("../src/server/server.js")
http = require('http')

expect = require('chai').expect


describe 'server', -> 
  afterEach ->
    server.stop()

  it 'should start a server on port 8080', (done)->
    server.start(PORT)
    request = http.get 'http://localhost:8080'
    request.on 'response', (response) ->
      response.on 'data', ->
        expect(response.statusCode).to.equal 200
      response.on 'end', ->
        done()

  it 'should return hello world', (done)->
    server.start(PORT)
    request = http.get 'http://localhost:8080'
    request.on 'response', (response) ->
      response.setEncoding('utf8')
      response.on 'data', (chunk) -> 
        expect(chunk).to.equal "Hello World"
      response.on 'end', ->
        done()
