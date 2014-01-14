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

  color: (color, silent) ->
    if color
      @_attrs.color = color
      @trigger 'change:color', silent: silent
    @_attrs.color

  soul: ->
    @_attrs.soul

  effect: (effect) ->
    if effect
      @_effect = effect
    @_effect

  revive: (soul, silent) ->
    currentSoul = @soul()
    if currentSoul and currentSoul isnt soul
      @grid().ablaze @, silent
    else
      @_applySoul soul, silent
    @

  _applySoul: (soul, silent) ->
    @_attrs.soul = soul
    @color soul.color(), silent
    @

  touch: (anotherCell, silent) ->
    effect = @effect()
    effect @, anotherCell, silent
    @

  grid: ->
    @_attrs.grid

Events = require '../../vendor/backbone/events'
_.extend Cell.prototype, Events

module.exports = Cell
