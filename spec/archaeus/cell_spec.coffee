describe 'Cell', ->

  Cell = require '../../src/archaeus/cell'
  cell = null

  grid =
    ablaze: sinon.spy()

  beforeEach ->
    cell = new Cell grid

  afterEach ->
    grid.ablaze.reset()

  it 'should have a blank color', ->
    color = cell.color()
    expect(color).to.equal Cell.BLANK_COLOR

  it 'should have a default position', ->
    position = cell.position()
    expect(position).to.equal Cell.DEFAULT_POSITION

  it 'should have a default touch effect', ->
    effect = cell.effect()
    expect(effect).to.equal Cell.DEFAULT_EFFECT

  it 'should belong to a grid', ->
    expect(cell.grid()).to.equal grid

  describe 'having a soul', ->

    soul = null

    beforeEach ->
      soul = color: sinon.stub().returns '#ff0000'
      cell.soul soul

    it 'should have a soul', ->
      expect(cell.soul()).to.equal soul

    it 'should have the soul\'s color', ->
      expect(cell.color()).to.equal soul.color()

    describe 'on revive', ->

      it 'should ablaze the grid around the cell', ->
        cell.revive()
        expect(grid.ablaze).to.have.been.calledWith cell

    describe 'and getting in touch with another cell', ->

      anotherCell = null
      effectSpy   = null

      beforeEach ->
        effectSpy   = sinon.spy()
        sinon.stub cell, '_effect', effectSpy
        anotherSoul = color: sinon.stub().returns '#ffff00'
        anotherCell = new Cell

      afterEach ->
        effectSpy.reset()
        cell._effect.restore()

      it 'should effect the cells somehow', ->
        cell.touch anotherCell
        expect(effectSpy).to.have.been.calledWith cell, anotherCell
