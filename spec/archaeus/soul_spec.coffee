describe 'Soul', ->

  Soul  = require '../../src/archaeus/soul'
  soul  = null
  color = 'ff0000'

  beforeEach ->
    soul = new Soul color: color

  it 'should generate an ID', ->
    expect(soul.id()).to.exist

  it 'should use an existing ID if provided', ->
    id = '123'
    soul = new Soul id: id, color: color
    expect(soul.id()).to.equal id

  it 'should have a color', ->
    expect(soul.color()).to.equal color

  it 'should throw an error if none or invalid color provided', ->
    expect(-> new Soul     ).to.throw(Error)
    expect(-> new Soul {}  ).to.throw(Error)
    expect(-> new Soul null).to.throw(Error)

  describe '#asJSON', ->

    it 'should return a JSON-ready Object of attributes', ->
      s = soul.asJSON()
      expect(s.id   ).to.equal soul.id()
      expect(s.color).to.equal soul.color()
