describe 'something', ->
  it 'is two', ->
    div = document.createElement('div')
    div.setAttribute('id', 'tdjs')
    div.setAttribute('foo', 'bar')
    document.body.appendChild(div)

    extractedDiv = document.getElementById('tdjs')
    expect(extractedDiv.getAttribute('foo')).to.equal('bar')
