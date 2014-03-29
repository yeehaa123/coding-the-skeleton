(function(){
  "use strict";
  var server = require('./server');
  var port = process.argv[2];
  var contentDir = 'src/server/content';
  server.start(contentDir + "/index.html", contentDir + "/404.html", port, function() {
    console.log("Server Started");
  });
})();
