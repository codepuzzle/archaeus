class Soul

  constructor: (attrs = {}) ->
    @_attrs =
      id:    attrs.id or @_guid()
      color: attrs.color or throw new Error 'A Soul needs a valid color', color
    @

  _guid: ->
    'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace /[xy]/g, (c) ->
      r = Math.random() * 16|0
      v = if c is 'x' then r else r&0x3|0x8
      v.toString 16

  id: =>
    @_attrs.id

  color: (color) ->
    if color
      @_attrs.color = color
    @_attrs.color

  asJSON: ->
    obj =
      id:    @id()
      color: @color()
    obj

module.exports = Soul
