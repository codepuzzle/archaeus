Backbone = require '../../vendor/backbone/view'

CellView = require './cell_view'

class GridView extends Backbone.View

  events:
    'mouseover .cell': 'interact'

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

  interact: (e) ->
    $cellEl = $(e.srcElement)
    x = $cellEl.data 'x'
    y = $cellEl.data 'y'

    cellView = @_cellViews["#{x}-#{y}"]
    cell = cellView.cell

    cell.revive @soul
    @

  remove: ->
    @_removeCellViews()
    Backbone.View::remove.call @
    @

  _removeCellViews: ->
    for key, view of @_cellViews
      view.remove()
      delete @_cellViews[key]
    @

module.exports = GridView
