Backbone = require '../../vendor/backbone/view'

CellView = require './cell_view'

class GridView extends Backbone.View

  el: '#content'

  events:
    'mouseover .cell': 'setSoul'

  initialize: (@soul, @grid) ->
    @_cellViews = {}
    @render()
    @

  render: ->
    # remove existing views and clean current el
    @_removeCellViews()
    @$el.empty()

    # traverse grid and render cells
    rows = @grid.cellRows()
    for row, x in rows
      $row = $('<div class="row"></div>')
      for cell, y in row
        @_renderCell $row, cell, x, y
      @$el.append $row
    @

  _renderCell: ($row, cell, x, y) ->
    key = "#{x}-#{y}"

    # remove existing view
    @_cellViews[key]?.remove()

    # append cell to row el
    cellView = new CellView cell, x, y
    $row.append cellView.el
    @_cellViews[key] = cellView
    @

  _removeCellViews: ->
    for key, view of @_cellViews
      view.remove()
      delete @_cellViews[key]
    @

  setSoul: (e) ->
    $cellEl = $(e.srcElement)
    x = $cellEl.data 'x'
    y = $cellEl.data 'y'

    cellView = @_cellViews["#{x}-#{y}"]
    cell = cellView.cell

    cell.soul @soul
    @

module.exports = GridView
