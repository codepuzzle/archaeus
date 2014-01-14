_    = require 'underscore'
Cell = require './cell'

class Grid

  constructor: (options) ->
    @_attrs = {}
    @_attrs.size =
      sizeX: options.sizeX
      sizeY: options.sizeY
    @_attrs.effect = options.effect
    @_initCells()
    @

  _initCells: ->
    @_attrs.cells =
      data: []
      positions: {}

    { sizeX, sizeY } = @size()
    for x in [0...sizeX]
      row = []
      @_attrs.cells.data.push row
      for y in [0...sizeY]
        @_addCellToRow row, x, y
    @

  _addCellToRow: (row, x, y) ->
    cell = new Cell @
    cell.id = "#{x}-#{y}"

    if effect = @effect()
      cell.effect effect

    row.push cell
    @_attrs.cells.positions[cell.id] = x: x, y: y
    @

  size: ->
    @_attrs.size

  effect: ->
    @_attrs.effect

  cellRows: ->
    @_attrs.cells.data

  cellPositions: ->
    @_attrs.cells.positions

  cellPosition: (cell) ->
    @_attrs.cells.positions[cell.id]

  cellAt: (x, y) ->
    if row = @_attrs.cells.data[x]
      cell = row[y]
    else
      null

  cells: ->
    _.flatten @_attrs.cells.data

  ablaze: (cellToAblaze, silent) ->
    if cellToAblaze.soul()
      ablazePos = @cellPosition cellToAblaze
      for dx in [-1..1]
        for dy in [-1..1]
          x = ablazePos.x - dx
          y = ablazePos.y - dy
          cell = @cellAt x, y
          if cell and cell isnt cellToAblaze
            cell.touch cellToAblaze, silent
    @

module.exports = Grid
