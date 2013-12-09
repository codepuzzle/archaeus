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
    cell = new Cell @
    cell.position x: x, y: y
    @cells().push cell
    @

  size: ->
    @_attrs.size

  cells: ->
    @_attrs.cells

  cellAt: (x, y) ->
    for cell in @cells()
      pos = cell.position()
      return cell if pos.x is x and pos.y is y
    null

  ablaze: (cellToAblaze) ->
    ablazePos = cellToAblaze.position()
    for cell in @cells()
      pos = cell.position()
      distanceX = Math.abs pos.x - ablazePos.x
      distanceY = Math.abs pos.y - ablazePos.y
      if cell isnt cellToAblaze and 1 >= distanceX and 1 >= distanceY
        cell.touch()

module.exports = Grid
