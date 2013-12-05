describe 'Soul', ->

  Soul  = require '../../src/archaeus/soul'
  soul  = null
  color = 'ff0000'

  beforeEach ->
    soul = new Soul color

  it 'should have a color', ->
    expect(soul.color()).to.equal color

  it 'should throw an error if none or invalid color provided', ->
    expect(-> new Soul).to.throw(Error)
    expect(-> new Soul null).to.throw(Error)
