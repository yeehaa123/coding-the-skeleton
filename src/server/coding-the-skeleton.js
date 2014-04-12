(function(){
  "use strict";
  var server = require('./server');
  var port = process.argv[2] || 3000;
  var contentDir = 'src/app';
  server.start(contentDir, contentDir + "/404.html", port, function() {
    console.log("Server Started");
  });
})();
