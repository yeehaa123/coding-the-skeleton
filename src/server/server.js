"use strict";

var http = require('http');
var server;

exports.start = function(portNumber){
  server = http.createServer();
  server.on("request", function(request, response) {
    var body = "Hello World";
    response.end(body);
  });
  server.listen(portNumber);
};

exports.stop = function(){
  server.close();
};
