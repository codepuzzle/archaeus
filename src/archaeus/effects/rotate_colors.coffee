Color = require 'color'

rotateColors = (cell, anotherCell) ->
  color        = Color cell.color()
  anotherColor = Color anotherCell.color()

  rotation = Math.round Math.random() * 180

  newColor          = color.rotate(rotation).hexString()
  newAlternateColor = anotherColor.rotate(rotation).hexString()

  cell.color newColor
  anotherCell.color newAlternateColor

module.exports = rotateColors
