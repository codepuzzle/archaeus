Color = require 'color'

mixColors = (cell, anotherCell) ->
  color        = Color cell.color()
  anotherColor = Color anotherCell.color()

  newColor          = color.lighten(0.05).mix(anotherColor).hexString()
  newAlternateColor = anotherColor.darken(0.05).mix(color).hexString()

  cell.color newColor
  anotherCell.color newAlternateColor

module.exports = mixColors
