Backbone = require '../../vendor/backbone/view'

class CellView extends Backbone.View

  tagName:   'span'
  className: 'cell'

  initialize: (@cell, @x, @y) ->
    @listenTo @cell, 'change:color', @applyCellColor
    @render()
    @

  render: ->
    @$el.attr 'id', "cell-#{@cell.id}"
    @$el.data 'x', @x
    @$el.data 'y', @y
    @

  applyCellColor: ->
    color = @cell.color()
    @$el.css
      backgroundColor: color
      boxShadow: "0 0 15px #{color}"

module.exports = CellView
