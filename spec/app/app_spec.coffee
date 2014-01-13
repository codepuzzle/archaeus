describe 'App', ->

  app      = null

  GridView      = null
  Grid          = null
  SocketService = null

  before ->
    GridView = require '../../app/views/grid_view'
    sinon.stub GridView.prototype, 'render', ->

    Grid = require '../../src/archaeus/grid'
    sinon.stub Grid.prototype, '_initCells', ->
      @_attrs.cells = data: [], positions: {}

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
    SocketService::connect.restore()

  it 'should init a soul', ->
    Soul = require '../../src/archaeus/soul'
    expect(app.soul).to.be.an.instanceof Soul

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
        @socket = on: ->

    before ->
      app.run()

    it 'should init a grid view', ->
      expect(app.gridView).to.be.an.instanceof GridView

    it 'should init $', ->
      expect($).to.be.defined

    it 'should init the socket service', ->
      expect(app.socketService).to.be.an.instanceof SocketService

    it 'should not render until the socket service has connected', ->
      expect(htmlSpy).not.to.be.called

    describe 'on socket service connect', ->

      before ->
        SocketService::connect.yieldTo 'connect'

      it 'should render the grid view html to the content', ->
        expect(htmlSpy).to.be.calledWith app.gridView.el
