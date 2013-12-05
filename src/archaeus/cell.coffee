class Cell

  @BLANK_COLOR      = '#000000'
  @DEFAULT_POSITION = x: 0, y: 0

  _attrs:
    soul:     null
    color:    null
    position: null

  constructor: ->
    @color    Cell.BLANK_COLOR
    @position Cell.DEFAULT_POSITION
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

module.exports = Cell
