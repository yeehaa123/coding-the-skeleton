"use strict";

var fs   = require('fs');
var http = require('http');
var server;

exports.start = function(htmlFileToServe, portNumber){

  if(!portNumber) {
    throw new Error("Port number is not specified");
  }

  if(!htmlFileToServe) {
    throw new Error("HTML file to serve is not specified");
  }

  server = http.createServer();

  server.on("request", function(request, response) {
    fs.readFile(htmlFileToServe, function(err,data) {
      if(err) {
        throw err;
      }
      response.end(data);
    });
  });

  server.listen(portNumber);
};

exports.stop = function(callback){
  server.close(callback);
};
