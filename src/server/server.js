"use strict";

var http = require('http');
var server;

exports.start = function(portNumber){
  if(!portNumber) {
    throw new Error("Port number is not specified");
  }

  server = http.createServer();

  server.on("request", function(request, response) {
    var body = "Hello World";
    response.end(body);
  });

  server.listen(portNumber);
};

exports.stop = function(callback){
  server.close(callback);
};
