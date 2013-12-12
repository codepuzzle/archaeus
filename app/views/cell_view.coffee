Backbone = require '../../vendor/backbone/view'

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
    grid.ablaze @cell
    @

  applyCellColor: ->
    color = @cell.color()
    @$el.css
      backgroundColor: color
      boxShadow: "0 0 15px #{color}"


module.exports = CellView
