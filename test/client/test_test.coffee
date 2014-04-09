describe 'Application Container', ->
  it 'should be initialized in predefined div', ->
    containerDiv = document.createElement('div')
    containerDiv.setAttribute('id', 'cts-application-container')
    document.body.appendChild(containerDiv)

    cts.initializeApplication()

    extractedDiv = document.getElementById('cts-application-container')
    expect(extractedDiv).to.be.ok
