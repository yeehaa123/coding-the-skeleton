http = require('http')
child_process = require('child_process')
fs = require('fs')
expect = require('chai').expect

child = {}

exports.httpGet = (url, callback) ->
  request = http.get url

  request.on 'response', (response) ->
    receivedData = ""
    response.setEncoding('utf8')

    response.on 'data', (chunk) -> 
      receivedData += chunk

    response.on 'end', ->
      callback(response, receivedData)


exports.runServer = (callback) ->
  child = child_process.spawn 'node', ['src/server/coding_the_skeleton', 8080]
  child.stdout.setEncoding('utf8')
  child.stdout.on "data", (chunk) ->
    callback() if chunk.trim() is "Server Started"

exports.killServer = (callback) ->
  child.on 'exit', (code, signal) ->
    console.log("Server Exited: #{code} - #{signal}")
    callback()
  child.kill()

exports.createFile = (file, data) ->
  fs.writeFileSync(file, data)
  expect(fs.existsSync(file)).to.be.ok

exports.cleanUpFiles = (files) ->
  files.forEach (file) ->
    fs.unlinkSync(file)
    expect(!fs.existsSync(file)).to.be.ok
