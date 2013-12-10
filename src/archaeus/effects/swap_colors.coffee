swapColors = (cell, anotherCell) ->
  color        = cell.color()
  anotherColor = anotherCell.color()
  cell.color anotherColor
  anotherCell.color color

module.exports = swapColors
