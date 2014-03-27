server = require('../src/server/server.js')
expect = require('chai').expect

describe 'server', -> 
  it 'should return the number 3', ->
    expect(server.number()).to.equal(3)
