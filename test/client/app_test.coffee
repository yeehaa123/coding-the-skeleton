describe 'LearnTopicsController', ->

  beforeEach module("learnApp")

  beforeEach inject ($controller, $rootScope) ->
    @scope = $rootScope.$new()
    @mockLearnData = sinon.stub({getAllTopics: ->})
    @controllerConstructor = $controller

  it "should set the scope learnTopics to learnData.getAllTopics", ->
    learnTopics = [1,2,3];
    @mockLearnData.getAllTopics.returns learnTopics

    @controllerConstructor("LearnTopicsController",
      {$scope: @scope, $location: {}, learnData: @mockLearnData})

    expect(@scope.learnTopics).to.eql(learnTopics)
