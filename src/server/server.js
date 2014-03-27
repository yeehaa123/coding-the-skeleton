"use strict";

var http = require('http');
var server;

exports.start = function(){
  server = http.createServer();
  server.on("request", function(request, response) {
    var body = "<h1>Hello World</h1>";
    response.end(body);
  });
  server.listen(8080);
};

exports.stop = function(){
  server.close();
};
