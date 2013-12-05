class Soul

  constructor: (color) ->
    unless color
      throw new Error 'A Soul needs a valid color', color
    @_attrs =
      color: color
    @

  color: (color) ->
    if color
      @_attrs.color = color
    @_attrs.color

module.exports = Soul
