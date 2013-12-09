describe 'Grid', ->

  Grid = require '../../src/archaeus/grid'
  grid = null

  size = 5

  beforeEach ->
    grid = new Grid sizeX: size, sizeY: size

  it 'should have a size', ->
    expect(grid.size().sizeX).to.eql size
    expect(grid.size().sizeY).to.eql size

  it 'should contain an amount of size*size cells', ->
    expect(grid.cells().length).to.eql size*size
