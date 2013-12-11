describe 'Grid', ->

  Grid = null
  grid = null

  Cell = null

  sizeX = 3
  sizeY = 4

  before ->
    Cell = require '../../src/archaeus/cell'
    sinon.stub Cell.prototype, 'touch'
    sinon.stub Cell.prototype, 'effect'
    Grid = require '../../src/archaeus/grid'

  beforeEach ->
    grid = new Grid sizeX: sizeX, sizeY: sizeY

  afterEach ->
    Cell.prototype.touch.reset()
    Cell.prototype.effect.reset()

  after ->
    Cell.prototype.touch.restore()
    Cell.prototype.effect.restore()

  it 'should have a size x', ->
    expect(grid.size().sizeX).to.equal sizeX

  it 'should have a size y', ->
    expect(grid.size().sizeY).to.equal sizeY

  it 'should apply an ID to the cells according to its position', ->
    cell = grid.cellAt 1, 2
    expect(cell.id).to.equal '1-2'

  describe 'given an optional effect as option', ->

    it 'should initialize the cells with an effect', ->
      effect = ->
      grid = new Grid sizeX: 1, sizeY: 1, effect: effect
      cell = grid.cellAt 0, 0
      expect(cell.effect).to.be.calledWith effect

  describe '#cellRows', ->

    cellRows = null

    beforeEach ->
      cellRows = grid.cellRows()

    it "should return an amount of #{sizeX} cell rows", ->
      expect(cellRows.length).to.equal sizeX

    it "should return an amount of #{sizeY} cells per row", ->
      firstRow = cellRows[0]
      expect(firstRow.length).to.equal sizeY

    it "should return an amount of #{sizeY} cells per row", ->
      firstRow = cellRows[0]
      expect(firstRow.length).to.equal sizeY

  describe '#cellPositions', ->

    cellPositions = null

    beforeEach ->
      cellPositions = grid.cellPositions()

    it 'should return a key-value Object associating cell-IDs to cell positions', ->
      pos = cellPositions['1-2']
      expect(pos.x).to.equal 1
      expect(pos.y).to.equal 2

    it "should return an amount of #{sizeX * sizeY} cell positions", ->
      _ = require 'underscore'
      positions = _.keys cellPositions
      expect(positions.length).to.equal sizeX * sizeY

  describe '#cellAt', ->

    it 'should return the cell at a given position', ->
      cell = grid.cellAt 2, 1
      expect(cell.id).to.equal '2-1'

  describe '#ablaze', ->

    it 'should touch all cells surrounding a given cell', ->
      cell = grid.cellAt 1, 1
      grid.ablaze cell
      expect(Cell::touch).to.be.calledOn     grid.cellAt(0, 0)
      expect(Cell::touch).to.be.calledOn     grid.cellAt(0, 1)
      expect(Cell::touch).to.be.calledOn     grid.cellAt(0, 2)
      expect(Cell::touch).to.be.calledOn     grid.cellAt(1, 0)
      expect(Cell::touch).not.to.be.calledOn grid.cellAt(1, 1)
      expect(Cell::touch).to.be.calledOn     grid.cellAt(1, 2)
      expect(Cell::touch).to.be.calledOn     grid.cellAt(2, 0)
      expect(Cell::touch).to.be.calledOn     grid.cellAt(2, 1)
      expect(Cell::touch).to.be.calledOn     grid.cellAt(2, 2)
