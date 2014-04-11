describe 'learnApp', ->
  beforeEach module("learnApp")

  describe 'LearnTopicsController', ->

    beforeEach inject ($controller, $rootScope) ->
      @scope = $rootScope.$new()
      @mockLearnData = sinon.stub({getAllTopics: ->})
      @controllerConstructor = $controller

    it "should set the scope learnTopics to learnData.getAllTopics", ->
      learnTopics = [1,2,3]
      @mockLearnData.getAllTopics.returns learnTopics

      @controllerConstructor("LearnTopicsController",
        {$scope: @scope, $location: {}, learnData: @mockLearnData})

      expect(@scope.learnTopics).to.eql(learnTopics)

  describe 'learnData', ->

    beforeEach inject (learnData) ->
      @learnData = learnData

    it "allows us to get data from the service", ->
      learnTopics = [1,2,3]
      expect(@learnData.getAllTopics()).to.eql(learnTopics) 
