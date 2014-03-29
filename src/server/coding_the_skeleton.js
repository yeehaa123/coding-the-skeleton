(function(){
  "use strict";
  var server = require('./server');
  server.start("src/server/content/index.html", "src/server/content/404.html", "9778", function() {
    console.log("Server Started");
  });
})();
