describe 'Effects.swapColors', ->

  Effects = require '../../../src/archaeus/effects'
  Cell    = require '../../../src/archaeus/cell'

  cell        = null
  anotherCell = null

  red  = 'red'
  blue = 'blue'

  beforeEach ->
    cell        = new Cell
    cell.color red

    anotherCell = new Cell
    anotherCell.color blue

  it 'should be a function', ->
    expect(Effects.swapColors).to.be.a 'function'

  it 'should swap two cells colors', ->
    Effects.swapColors cell, anotherCell
    expect(cell.color()).to.equal blue
    expect(anotherCell.color()).to.equal red
