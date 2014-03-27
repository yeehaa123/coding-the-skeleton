"use strict";

var http = require('http');
var server;

exports.start = function(){
  console.log("start called");
  server = http.createServer();
  server.on("request", function(request, response) {
    response.end();
  });
  server.listen(8080);
};

exports.stop = function(callback){
  server.close(callback);
};
