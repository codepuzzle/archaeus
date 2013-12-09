Effects = require './effects'

class Cell

  @BLANK_COLOR      = '#000000'
  @DEFAULT_POSITION = x: 0, y: 0
  @DEFAULT_EFFECT   = Effects.swapColors

  constructor: (grid) ->
    @_attrs =
      grid:     grid
      soul:     null
      color:    Cell.BLANK_COLOR
      position: Cell.DEFAULT_POSITION

    @effect Cell.DEFAULT_EFFECT
    @

  color: (color) ->
    if color
      @_attrs.color = color
    @_attrs.color

  position: (position) ->
    if position
      @_attrs.position = position
    @_attrs.position

  soul: (soul) ->
    if soul
      @_attrs.soul = soul
      @color soul.color()
    @_attrs.soul

  effect: (effect) ->
    if effect
      @_effect = effect
    @_effect

  revive: ->
    @grid().ablaze @
    @

  touch: (anotherCell) ->
    effect = @effect()
    effect @, anotherCell
    @

  grid: ->
    @_attrs.grid

module.exports = Cell
