describe 'Grid', ->

  Grid = null
  grid = null

  Cell = null

  size = 5

  before ->
    Cell = require '../../src/archaeus/cell'
    sinon.stub Cell.prototype, 'touch'
    Grid = require '../../src/archaeus/grid'

  beforeEach ->
    grid = new Grid sizeX: size, sizeY: size

  after ->
    Cell.prototype.touch.restore()

  it 'should have a size', ->
    expect(grid.size().sizeX).to.eql size
    expect(grid.size().sizeY).to.eql size

  it 'should contain an amount of size*size cells', ->
    expect(grid.cells().length).to.eql size*size

  describe '#cellAt', ->

    it 'should return the cell at a given position', ->
      cell = grid.cellAt 4, 3
      position = cell.position()
      expect(position.x).to.equal 4
      expect(position.y).to.equal 3

  describe '#ablaze', ->

    it 'should touch all cells surrounding a given cell', ->
      cell = grid.cellAt 2, 2
      grid.ablaze cell
      expect(grid.cellAt(1, 1).touch).to.be.called
      expect(grid.cellAt(1, 2).touch).to.be.called
      expect(grid.cellAt(1, 3).touch).to.be.called
      expect(grid.cellAt(2, 1).touch).to.be.called
      expect(grid.cellAt(2, 3).touch).to.be.called
      expect(grid.cellAt(3, 1).touch).to.be.called
      expect(grid.cellAt(3, 2).touch).to.be.called
      expect(grid.cellAt(3, 3).touch).to.be.called
