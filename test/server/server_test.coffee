server = require("../../src/server/server.js")
expect = require('chai').expect

helpers = require('./helpers/test_helpers')
httpGet = helpers.httpGet
createFile = helpers.createFile
cleanUpFiles = helpers.cleanUpFiles

describe 'server', -> 
  PORT = 8080
  BASE_URL = "http://localhost:#{PORT}"

  testDir  = 'generated/test'
  homePageFile = "#{testDir}/index.html"
  errorPageFile = "#{testDir}/errorpage.html"

  describe 'basic functionality', (done) ->

    it 'should throw an exception if port is not specified', (done) ->
      expect(-> server.start(testDir)).to.throw(/Port number is not specified/)
      done()

    it 'should throw an exception if stop is called twice', (done) ->
       server.start(testDir, errorPageFile, PORT)
       server.stop()
       expect(-> server.stop()).to.throw(/Not running/)
       done()

    it 'should throw an exception if directory to serve is not specified', (done) ->
      expect(-> server.start(null, errorPageFile, PORT)).to.throw(/directory to serve is not specified/)
      done()

    it 'should throw an exception if 404 page to serve is not specified', (done) ->
      expect(-> server.start(testDir, null, PORT)).to.throw(/error page to serve is not specified/)
      done()


  describe 'static file serving', -> 
    expectedHomePageData = "Hello World"
    expectedErrorPageData = "Page Not Found"
    
    before (done) ->
      createFile(homePageFile, expectedHomePageData)
      createFile(errorPageFile, expectedErrorPageData)
      done()

    beforeEach (done) ->
      server.start testDir, errorPageFile, PORT, ->
        done()

    afterEach (done) ->
      server.stop ->
        done()

    after (done) ->
      cleanUpFiles([homePageFile, errorPageFile])
      done()

    it 'should return homepage when asked for /', (done) ->
      httpGet "#{BASE_URL}", (response, responseData) ->
        expect(response.statusCode).to.equal 200
        expect(responseData).to.equal expectedHomePageData
        done()

    it 'should return homepage when asked for index', (done) ->
      httpGet "#{BASE_URL}/index.html", (response, responseData) ->
        expect(response.statusCode).to.equal 200
        done()

    it 'should return a 404 for everything but homepage', (done) ->

      httpGet "#{BASE_URL}/vlindex.html", (response, responseData) ->
        expect(response.statusCode).to.equal 404
        expect(responseData).to.equal expectedErrorPageData
        done()
