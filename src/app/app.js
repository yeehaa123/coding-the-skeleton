/* global angular */

var learnApp = angular.module('learnApp', []);

var learnData = {
  getAllTopics: function(){
    'use strict';
    return [1,2,3];
  }
};

learnApp.controller('LearnTopicsController',
  function LearnTopicsController($scope, $location) {
    'use strict';
    $scope.learnTopics = learnData.getAllTopics();
  }
);
