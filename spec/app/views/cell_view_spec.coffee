describe 'CellView', ->

  x        = 2
  y        = 3
  cellView = null

  before ->
    CellView = require '../../../app/views/cell_view'
    sinon.spy CellView.prototype, 'render'
    sinon.spy CellView.prototype, 'interact'

    Cell     = require '../../../src/archaeus/cell'
    sinon.stub Cell.prototype, 'revive', ->
    grid     = {}
    cell     = new Cell grid
    cellView = new CellView cell, x, y

  after ->
    cellView.cell.revive.restore()
    cellView.render.restore()
    cellView.interact.restore()

  it 'should render', ->
    expect(cellView.render).to.be.calledOnce

  it 'should interact on mouse over element', ->
    cellView.$el.trigger 'mouseover'
    expect(cellView.interact).to.be.calledOnce
    cellView.interact.reset()

  describe 'on cell color change', ->

    color = 'rgb(15, 15, 15)'

    before ->
      cellView.cell.color color

    it 'should apply the new cell color to the element', ->
      expect(cellView.$el.css('backgroundColor')).to.equal color

  describe '#render', ->

    $el = null

    before ->
      $el = cellView.$el
      cellView.render()

    it 'should render a cell element', ->
      expect($el.attr('class')).to.contain 'cell'

    it 'should set a cell element id depending on the cell id', ->
      expect($el.attr('id')).to.equal "cell-#{cellView.cell.id}"

    it 'should set cell x position information as element data', ->
      expect($el.data('x')).to.equal x

    it 'should set cell y position information as element data', ->
      expect($el.data('y')).to.equal y

  describe '#interact', ->

    grid = null

    before ->
      grid = cellView.cell.grid()
      cellView.interact()

    it 'should revive the cell', ->
      expect(cellView.cell.revive).to.be.called
