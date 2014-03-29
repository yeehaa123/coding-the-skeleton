expect = require('chai').expect

http = require('http')

child_process = require('child_process')
child = {}

afterEach (done) ->
  child.on 'exit', (code, signal) ->
    console.log('done')
  child.kill()
  done()

describe 'smoke test', ->
  it 'should get the homepage from the server', (done) ->    
    runServer ->
      httpGet 'http://localhost:9778', (response, receivedData) ->
        done()

runServer = (callback) ->
  child = child_process.spawn 'node', ['src/server/coding_the_skeleton', 9778]
  child.stdout.setEncoding('utf8')
  child.stdout.on "data", (chunk) ->
    process.stdout.write("server stdout #{chunk}")
    callback() if chunk.trim() is "Server Started"
  child.stderr.on "data", (chunk) ->
    process.stderr.write("server stderr #{chunk}")
    console.log('stderror' + chunk)
  child.on "exit", (code, signal) ->
    console.log('exit' + code + " - " + signal)

httpGet = (url, callback) ->
  request = http.get url

  request.on 'response', (response) ->
    receivedData = ""
    response.setEncoding('utf8')

    response.on 'data', (chunk) -> 
      receivedData += chunk

    response.on 'end', ->
      callback(response, receivedData)
