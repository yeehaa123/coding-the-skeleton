server = require("../src/server/server.js")
expect = require('chai').expect

http = require('http')
fs = require('fs')
PORT = 8080

testDir  = 'generated/test'
homePageFile = "#{testDir}/homepage.html"
errorPageFile = "#{testDir}/errorpage.html"

describe 'server', -> 

  describe 'basic functionality', (done) ->

    it 'should throw an exception if port is not specified', (done) ->
      expect(-> server.start(homePageFile)).to.throw(/Port number is not specified/)
      done()

    it 'should throw an exception if stop is called twice', (done) ->
       server.start(homePageFile, errorPageFile, PORT)
       server.stop()
       expect(-> server.stop()).to.throw(/Not running/)
       done()

    it 'should throw an exception if homepage to serve is not specified', (done) ->
      expect(-> server.start(null, errorPageFile, PORT)).to.throw(/homepage to serve is not specified/)
      done()

    it 'should throw an exception if 404 page to serve is not specified', (done) ->
      expect(-> server.start(homePageFile, null, PORT)).to.throw(/error page to serve is not specified/)
      done()


  describe 'static file serving', -> 


    after (done) ->
      cleanUpFiles([homePageFile, errorPageFile])
      done()

    it 'should return homepage when asked for /', (done) ->

      expectedHomePageData = "Hello World"
      createFile(homePageFile, expectedHomePageData)

      httpGet 'http://localhost:8080', (response, responseData) ->
        expect(response.statusCode).to.equal 200
        expect(responseData).to.equal expectedHomePageData
        done()

    it 'should return homepage when asked for index', (done) ->
      httpGet 'http://localhost:8080/index.html', (response, responseData) ->
        expect(response.statusCode).to.equal 200
        done()

    it 'should return a 404 for everything but homepage', (done) ->

      expectedErrorPageData = "Page Not Found"
      createFile(errorPageFile, expectedErrorPageData)

      httpGet 'http://localhost:8080/blabla', (response, responseData) ->
        expect(response.statusCode).to.equal 404
        expect(responseData).to.equal expectedErrorPageData
        done()


createFile = (file, data) ->
  fs.writeFileSync(file, data)
  expect(fs.existsSync(file)).to.be.ok

cleanUpFiles = (files) ->
  files.forEach (file) ->
    fs.unlinkSync(file)
    expect(!fs.existsSync(file)).to.be.ok

httpGet = (url, callback) ->
  server.start(homePageFile, errorPageFile, PORT);
  request = http.get url

  request.on 'response', (response) ->
    receivedData = ""
    response.setEncoding('utf8')

    response.on 'data', (chunk) -> 
      receivedData += chunk

    response.on 'end', ->
      server.stop ->
        callback(response, receivedData)
