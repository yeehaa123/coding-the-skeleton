http = require('http')
child_process = require('child_process')
fs = require('fs')
expect = require('chai').expect
procfile = require('procfile')

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


exports.runServer = (params, callback) ->
  child = child_process.spawn params.command, params.options
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

exports.parseProcFile = (path) ->
  path = path || 'Procfile'
  fileData = fs.readFileSync(path, 'utf8')
  webCommand = procfile.parse(fileData).web
  webCommand.options[1] = 5000
  webCommand
