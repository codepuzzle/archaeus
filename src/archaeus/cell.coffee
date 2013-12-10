_               = require 'underscore'

swapColorEffect = require './effects/swap_colors'

class Cell

  @BLANK_COLOR      = '#0000ff'
  @DEFAULT_EFFECT   = swapColorEffect

  constructor: (grid) ->
    @_attrs =
      grid:     grid
      soul:     null
      color:    Cell.BLANK_COLOR

    @effect Cell.DEFAULT_EFFECT
    @

  color: (color) ->
    if color
      @_attrs.color = color
      @trigger 'change:color'
    @_attrs.color

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

Backbone = require '../../vendor/backbone.view'
_.extend Cell.prototype, Backbone.Events

module.exports = Cell
