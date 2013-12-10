Backbone = require '../../vendor/backbone.view'

class CellView extends Backbone.View

  tagName:   'span'
  className: 'cell'

  events:
    'mouseover': 'interact'

  initialize: (@cell, @x, @y) ->
    @listenTo @cell, 'change:color', @applyCellColor
    @render()
    @

  render: ->
    x = @x
    y = @y
    @$el.attr 'id', "cell-#{x}-#{y}"
    @$el.data 'x', x
    @$el.data 'y', y
    @

  interact: ->
    x = @x
    y = @y
    grid = @cell.grid()
    if @cell.soul()
      grid.ablaze @cell
    @

  applyCellColor: ->
    @$el.css backgroundColor: @cell.color()

module.exports = CellView
