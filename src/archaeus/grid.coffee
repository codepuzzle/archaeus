Cell = require './cell'

class Grid

  constructor: (size) ->
    @_attrs = {}
    @_attrs.size = size
    @_initCells()
    @

  _initCells: ->
    @_attrs.cells = []
    { sizeX, sizeY } = @size()
    for x in [1..sizeX]
      for y in [1..sizeY]
        @_addCell x, y
    @

  _addCell: (x, y) ->
    cell = new Cell
    cell.position x: x, y: y
    @cells().push cell
    @

  size: ->
    @_attrs.size

  cells: ->
    @_attrs.cells

module.exports = Grid
