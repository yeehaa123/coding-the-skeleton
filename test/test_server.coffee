server = require("../src/server/server.js")
http = require('http')

expect = require('chai').expect

after ()->
  server.stop ->
    console.log("stopped")

describe 'server', -> 
  it 'should start the server', (done)->
    server.start()
    http.get 'http://localhost:8080', (response) ->
      console.log response.statusCode
      done()
