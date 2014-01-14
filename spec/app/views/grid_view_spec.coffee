describe 'GridView', ->

  gridView = null
  sizeX    = 3
  sizeY    = 3

  Cell     = null

  before ->
    GridView = require '../../../app/views/grid_view'
    sinon.spy GridView.prototype, 'render'
    sinon.spy GridView.prototype, 'interact'

    Cell     = require '../../../src/archaeus/cell'
    sinon.spy Cell.prototype, 'revive'

    Grid     = require '../../../src/archaeus/grid'
    soul     = color: sinon.stub()
    effect   = sinon.stub()
    grid     = new Grid sizeX: sizeX, sizeY: sizeY, effect: effect
    gridView = new GridView soul, grid

  after ->
    Cell::revive.restore()
    gridView.render.restore()
    gridView.interact.restore()

  it 'should render', ->
    expect(gridView.render).to.be.calledOnce

  it.skip 'should apply the grid\'s soul on the cell on mouse over', ->
    $cell = gridView.$('.cell').first()
    $cell.trigger 'mouseover'
    expect(gridView.interact).to.be.calledOnce
    gridView.interact.reset()

  describe '#render', ->

    $el = null

    before ->
      $el = gridView.$el
      gridView.render()

    it "should render #{sizeX} rows of cells", ->
      $rows = gridView.$('.row')
      expect($rows.length).to.equal sizeX

    it "should render #{sizeY} cells per row", ->
      $cells = gridView.$('.row').first().find('.cell')
      expect($cells.length).to.equal sizeY

    it "should render a total of #{sizeX * sizeY} cells", ->
      $cells = gridView.$('.cell')
      expect($cells.length).to.equal sizeX * sizeY

  describe '#interact', ->

    x = 1
    y = 1

    before ->
      $row   = $(gridView.$('.row')[x])
      cellEl = $row.find('.cell')[y]
      event = srcElement: cellEl
      gridView.interact event

    it 'should revive the grid\'s cell by the soul', ->
      cell = gridView.grid.cellAt x, y
      expect(cell.revive).to.be.calledWith gridView.soul
