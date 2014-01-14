Soul     = require 'src/archaeus/soul'
Grid     = require 'src/archaeus/grid'

GridView      = require 'app/views/grid_view'
SocketService = require 'app/services/socket_service'

class App

  constructor: ->
    @souls = {}
    @_initSoul()
    @_initGrid()
    @

  _initSoul: ->
    Color = require "color"
    r = Math.round Math.random() * 255
    g = Math.round Math.random() * 255
    b = Math.round Math.random() * 255
    color = Color(r: r, g: g, b: b).hexString()
    @soul = @_rememberSoul color: color
    @

  _rememberSoul: (data) ->
    if data?.id and soul = @souls[data.id]
      soul
    else
      soul = new Soul data
      @souls[soul.id()] = soul
      soul

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
      cell.on 'change:color', (data) ->
        cell = @
        self.emitCellEvent cell unless data.silent
    @

  emitCellEvent: (cell) ->
    pos = cell.id.split '-'
    data =
      color: cell.color()
      x:     pos[0]
      y:     pos[1]
    if soul = cell.soul()
      data.soul = soul.asJSON()
    @socketService.emit 'cell:change', data
    @

  _registerIncomingEvents: ->
    @socketService.on 'cell:change', @handleCellEvent, @
    @

  handleCellEvent: (data) =>
    cell = @gridView.grid.cellAt data.x, data.y
    if cell
      if data.soul
        soul = @_rememberSoul data.soul
        cell.revive soul, true
      cell.color data.color, true
    @

module.exports = App
