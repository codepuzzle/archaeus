Color = require 'color'

rotateColors = (cell, anotherCell, silent) ->
  color        = Color cell.color()
  anotherColor = Color anotherCell.color()

  rotation = Math.round Math.random() * 180

  newColor          = color.rotate(rotation).hexString()
  newAlternateColor = anotherColor.rotate(rotation).hexString()

  cell.color newColor, silent
  anotherCell.color newAlternateColor, silent

module.exports = rotateColors
