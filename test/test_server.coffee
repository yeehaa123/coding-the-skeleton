server = require("../src/server/server.js")
http = require('http')

expect = require('chai').expect


describe 'server', -> 
  after ()->
    server.stop ->
      console.log("stopped")

  describe 'basic behaviour', ->
    it 'should start the server', (done)->
      server.start()
      http.get 'http://localhost:8080', (response) ->
        done()
