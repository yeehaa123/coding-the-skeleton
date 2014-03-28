"use strict";

var fs   = require('fs');
var http = require('http');
var server;

exports.start = function(homePageToServe, errorPageToServe, portNumber){

  if(!portNumber) throw new Error("Port number is not specified");
  if(!homePageToServe) throw new Error("homepage to serve is not specified");
  if(!errorPageToServe) throw new Error("error page to serve is not specified");

  server = http.createServer();

  server.on("request", function(request, response) {
    if(request.url === '/' || request.url === '/index.html') {
      response.statusCode = 200;
      serveFile(homePageToServe, response);
    } else {
      response.statusCode = 404;
      serveFile(errorPageToServe, response);
    }
  });

  server.listen(portNumber);
};

exports.stop = function(callback){
  server.close(callback);
};

function serveFile(fileToServe, response){
  fs.readFile(fileToServe, function(err,data) {
    if(err) throw err;
    response.end(data);
  });
}
