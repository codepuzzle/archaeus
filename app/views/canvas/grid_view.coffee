Backbone = require '../../../vendor/backbone/view'

class CanvasGridView extends Backbone.View

  tagName: 'canvas'

  size: 18

  events:
    'mousemove': 'interact'

  initialize: (@soul, @grid) ->
    @render()
    @

  render: ->
    @context = @el.getContext '2d'
    @el.width  = window.innerWidth
    @el.height = window.innerHeight
    @_renderGrid()
    @

  _renderGrid: =>
    # this would create a loop, only necessary for permanent animations
    window.requestAnimationFrame @_renderGrid
    @context.clearRect 0, 0, @el.width, @el.height
    rows = @grid.cellRows()
    @_cells = {}
    for row, y in rows
      for cell, x in row
        @_cells["#{x}-#{y}"] = cell
        @_renderCell cell, x, y

  _renderCell: (cell, x, y) ->
    if cell.soul()
      canvasX = x * @size * 2 + @size
      canvasY = y * @size * 2 + @size
      @context.fillStyle = cell.color()
      @context.beginPath()
      @context.arc canvasX, canvasY, @size, 0, Math.PI * 2
      @context.fill()
      @context.closePath()
    @

  interact: (e) =>
    rect      = @el.getBoundingClientRect()
    mouseX    = e.clientX - rect.left
    mouseY    = e.clientY - rect.top
    x         = parseInt mouseX / @size / 2
    y         = parseInt mouseY / @size / 2
    mouseOver = "#{x}-#{y}"
    if mouseOver isnt @_mouseOver
      @_mouseOver = mouseOver
      if cell = @_cells[mouseOver]
        cell.revive @soul
    @

module.exports = CanvasGridView
