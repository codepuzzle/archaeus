describe 'Cell', ->

  Cell = require '../../src/archaeus/cell'
  cell = null

  beforeEach ->
    cell = new Cell

  it 'should have a blank color', ->
    color = cell.color()
    expect(color).to.equal Cell.BLANK_COLOR

  it 'should have a default position', ->
    position = cell.position()
    expect(position).to.equal Cell.DEFAULT_POSITION

  describe 'having a soul', ->

    soul = null

    beforeEach ->
      soul =
        color: sinon.stub().returns '#ff0000'
      cell.soul soul

    it 'should have a soul', ->
      expect(cell.soul()).to.equal soul

    it 'should have the soul\'s color', ->
      expect(cell.color()).to.equal soul.color()
