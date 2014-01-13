Soul     = require 'src/archaeus/soul'
Grid     = require 'src/archaeus/grid'

GridView      = require 'app/views/grid_view'
SocketService = require 'app/services/socket_service'

class App

  constructor: ->
    @_initSoul()
    @_initGrid()
    @

  _initSoul: ->
    Color = require "color"
    r = Math.round Math.random() * 255
    g = Math.round Math.random() * 255
    b = Math.round Math.random() * 255
    color = Color(r: r, g: g, b: b).hexString()
    @soul = new Soul color
    @

  _initGrid: ->
    { sizeX, sizeY } = @gridSize()
    effect           = @effect()
    @grid = new Grid
      sizeX: sizeX
      sizeY: sizeY
      effect: effect
    @

  gridSize: ->
    $container = $(window)
    height     = $container.height()
    width      = $container.width()
    cellSize   = @cellSize()
    size =
      sizeX: Math.round height / cellSize
      sizeY: Math.round width / cellSize

  cellSize: ->
    18

  effect: ->
    require 'src/archaeus/effects/rotate_colors'

  run: ->
    @_initGridView()
    @_init$()
    @_initSocketService()
    @_registerOutgoingEvents()
    @_registerIncomingEvents()
    @

  _initGridView: ->
    @gridView = new GridView @soul, @grid
    @

  _init$: ->
    require 'zepto'
    @

  _initSocketService: ->
    @socketService = new SocketService
    @socketService.connect
      connect: @_render
    @

  _render: =>
    $('#content').html @gridView.el
    @

  _registerOutgoingEvents: ->
    self = @
    for cell in @gridView.grid.cells()
      self = @
      handle = (data) ->
        cell = @
        self.emitCellEvent cell unless data.silent
      cell.on 'change:color', handle, cell
    @

  emitCellEvent: (cell) ->
    pos = cell.id.split '-'
    @socketService.emit 'cell:change',
      color: cell.color()
      x:     pos[0]
      y:     pos[1]
    @

  _registerIncomingEvents: ->
    @socketService.on 'cell:change', @handleCellEvent, @
    @

  handleCellEvent: (data) =>
    cell = @gridView.grid.cellAt data.x, data.y
    if cell
      cell.color data.color, true
    @

module.exports = App
