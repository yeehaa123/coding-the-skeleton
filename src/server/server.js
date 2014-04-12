"use strict";

var fs   = require('fs');
var http = require('http');
var send = require('send');
var server;

exports.start = function(contentDir, errorPageToServe, portNumber, callback) {

  if(!portNumber) throw new Error("Port number is not specified");
  if(!contentDir) throw new Error("directory to serve is not specified");
  if(!errorPageToServe) throw new Error("error page to serve is not specified");

  server = http.createServer();

  server.on("request", function(request, response) {
    send(request, request.url)
      .root(contentDir)
      .on('error', handleError)
      .pipe(response);

    function handleError(err) {
      if (err.status === 404) serveFile(response, 404, errorPageToServe);
      else throw err;
    }
  });

  server.listen(portNumber, callback);
};

exports.stop = function(callback){
  server.close(callback);
};

function serveFile(response, statusCode, fileToServe){
  response.statusCode = statusCode;
  fs.readFile(fileToServe, function(err,data) {
    if(err) throw err;
    response.end(data);
  });
}
