(function(){
  "use strict";
  var server = require('./server');
  server.start("index.html", "404.html", "9778", function() {
    console.log("Server Started");
  });
})();
