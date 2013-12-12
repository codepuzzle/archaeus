describe 'GridView', ->

  gridView = null
  sizeX    = 3
  sizeY    = 3

  before ->
    GridView = require '../../../app/views/grid_view'
    sinon.spy GridView.prototype, 'render'
    sinon.spy GridView.prototype, 'applySoul'

    Grid     = require '../../../src/archaeus/grid'
    soul     = color: sinon.stub()
    effect   = sinon.stub()
    grid     = new Grid sizeX: sizeX, sizeY: sizeY, effect: effect
    gridView = new GridView soul, grid

  after ->
    gridView.render.restore()
    gridView.applySoul.restore()

  it 'should render', ->
    expect(gridView.render).to.be.calledOnce

  it.skip 'should apply the grid\'s soul on the cell on mouse over', ->
    $cell = gridView.$('.cell').first()
    $cell.trigger 'mouseover'
    expect(gridView.applySoul).to.be.calledOnce
    gridView.applySoul.reset()

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

  describe '#applySoul', ->

    x = 1
    y = 1

    before ->
      $row   = $(gridView.$('.row')[x])
      cellEl = $row.find('.cell')[y]
      event = srcElement: cellEl
      gridView.applySoul event

    it 'should apply the grid\'s soul on a cell', ->
      cell = gridView.grid.cellAt x, y
      expect(cell.soul()).to.equal gridView.soul
