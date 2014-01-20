describe 'App', ->

  app      = null

  GridView      = null
  Grid          = null
  Cell          = null
  SocketService = null

  before ->
    GridView = require '../../app/views/grid_view'
    sinon.stub GridView.prototype, 'render', ->

    Grid = require '../../src/archaeus/grid'
    sinon.stub Grid.prototype, '_initCells', ->
      cell      = new Cell @
      cell.id   = "0-0"
      rows      = [[ cell ]]
      positions = { "0-0": x: 0, y: 0 }
      @_attrs.cells = data: rows, positions: positions

    Cell = require '../../src/archaeus/cell'
    sinon.spy Cell.prototype, 'on'
    sinon.spy Cell.prototype, 'color'
    sinon.spy Cell.prototype, 'revive'

    sinon.stub window, '$'
    window.$.withArgs(window).returns
      height: -> 54
      width:  -> 36

  before ->
    App = require '../../app/app'
    app = new App

  after ->
    window.$.restore()
    GridView::render.restore()
    Grid::_initCells.restore()
    Cell::on.restore()
    Cell::color.restore()
    Cell::revive.restore()
    SocketService::connect.restore()

  it 'should init a soul', ->
    Soul = require '../../src/archaeus/soul'
    expect(app.soul).to.be.an.instanceof Soul

  it 'should remember the initialized soul', ->
    rememberedSoul = app.souls[app.soul.id()]
    expect(rememberedSoul).to.equal app.soul

  it "should init a window-sized grid", ->
    Grid = require '../../src/archaeus/grid'
    expect(app.grid).to.be.an.instanceof Grid
    { sizeX, sizeY } = app.grid.size()
    gridSize = app.gridSize()
    expect(sizeX).to.equal gridSize.sizeX
    expect(sizeY).to.equal gridSize.sizeY

  describe '#run', ->

    htmlSpy = null

    before ->
      htmlSpy = sinon.spy()
      window.$.withArgs('#content').returns
        html: htmlSpy

    before ->
      SocketService = require '../../app/services/socket_service'
      sinon.stub SocketService.prototype, 'connect', ->
        @socket =
          on:   sinon.stub()
          emit: sinon.stub()
      sinon.spy SocketService.prototype, 'on'
      sinon.spy SocketService.prototype, 'emit'

    before ->
      app.run()

    after ->
      app.socketService.on.restore()
      app.socketService.emit.restore()

    it 'should init a grid view', ->
      expect(app.gridView).to.be.an.instanceof GridView

    it 'should init $', ->
      expect($).to.be.defined

    it 'should init the socket service', ->
      expect(app.socketService).to.be.an.instanceof SocketService

    it 'should not render until the socket service has connected', ->
      expect(htmlSpy).not.to.be.called

    it 'should register incoming cell:change events on the socket service', ->
      expect(app.socketService.on).to.be.calledWith 'cell:change'

    it 'should register outgoing change:color events for all grid cells on the socket service', ->
      numberOfCells = app.grid.cells().length
      expect(Cell.prototype.on.callCount).to.equal numberOfCells

    describe 'on socket service connect', ->

      before ->
        SocketService::connect.yieldTo 'connect'

      it 'should render the grid view html to the content', ->
        expect(htmlSpy).to.be.calledWith app.gridView.el

    describe '#emitCellEvent', ->

      it 'should emit the cell:change on the socket service', ->
        cell = app.grid.cellAt 0, 0
        soul = asJSON: -> id: '123', color: cell.color()
        cell._attrs.soul = soul

        app.emitCellEvent cell

        expect(app.socketService.emit).calledWith 'cell:change',
          soul:  soul.asJSON()
          color: cell.color()
          x:     '0'
          y:     '0'
        app.socketService.emit.reset()

    describe '#handleCellEvent', ->

      cell = null
      data = null

      beforeEach ->
        data =
          x:     0
          y:     0
          color: '#00ff00'
        cell = app.grid.cellAt data.x, data.y

      afterEach ->
        cell.color.reset()
        cell.revive.reset()

      it 'should color the cell silently', ->
        app.handleCellEvent data
        silent = true
        expect(cell.color).to.be.calledWith data.color, silent

      describe 'given a soul is provided', ->

        it 'should revive the cell silently', ->
          data.soul = app.soul.asJSON()
          app.handleCellEvent data
          silent = true
          expect(cell.revive).to.be.calledWith app.soul, silent

        it 'should remember the provided soul', ->
          id = '123'
          data.soul =
            id: id
            color: '#f0f0f0'
          app.handleCellEvent data
          expectedSoul = app.souls[id]
          expect(expectedSoul.asJSON()).to.eql data.soul

      describe 'given no soul is provided', ->

        it 'should not revive the cell', ->
          data.soul = null
          app.handleCellEvent data
          expect(cell.revive).not.to.be.called
