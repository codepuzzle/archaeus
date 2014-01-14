swapColors = (cell, anotherCell, silent) ->
  color        = cell.color()
  anotherColor = anotherCell.color()
  cell.color anotherColor, silent
  anotherCell.color color, silent

module.exports = swapColors
