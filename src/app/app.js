'use strict';

var learnApp = angular.module('learnApp', []);

learnApp.service('learnData', function() {
  return {
    getAllTopics: function(){
      return [1,2,3];
    }
  };
});

learnApp.controller('LearnTopicsController',
  function LearnTopicsController($scope, learnData) {
    $scope.learnTopics = learnData.getAllTopics();
  }
);
