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

  it 'should have a default touch effect', ->
    effect = cell.effect()
    expect(effect).to.equal Cell.DEFAULT_EFFECT

  it 'should belong to a grid', ->
    expect(cell.grid()).to.equal grid

  describe '#color', ->

    spy = null

    beforeEach ->
      spy = sinon.spy cell, 'trigger'

    afterEach ->
      spy.restore()

    it 'should trigger change:color', ->
      cell.color '#00ff00'
      expect(cell.trigger).calledWith 'change:color'

    describe 'given a silent flag', ->

      it 'should pass the silent flag to the trigger method', ->
        cell.color '#00ff00', true
        expect(cell.trigger).to.be.calledWith 'change:color', silent: true

  describe 'on revive', ->

    soul = null

    beforeEach ->
      soul = color: sinon.stub().returns '#ff0000'

    describe 'having no soul yet', ->

      beforeEach ->
        cell._attrs.soul = null
        cell.revive soul

      it 'should apply the given soul', ->
        expect(cell.soul()).to.equal soul

      it 'should have the soul\'s color', ->
        expect(cell.color()).to.equal soul.color()

    describe 'already having a soul', ->

      existingSoul = null

      beforeEach ->
        existingSoul = color: sinon.stub().returns '#00ffff'
        cell._attrs.soul = existingSoul
        cell.revive soul

      it 'should ablaze the grid around the cell', ->
        expect(grid.ablaze).to.have.been.calledWith cell

  describe 'on getting in touch with another cell', ->

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
