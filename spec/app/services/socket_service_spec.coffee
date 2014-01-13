describe 'SocketService', ->

  socketService = null
  io            = null
  callbacks     = null

  before ->
    socketStub = sinon.stub().returns
      on: sinon.stub()
      emit: sinon.stub()
    io = require 'socket.io'
    sinon.stub io, 'connect', socketStub

  before ->
    callbacks =
      connect: sinon.stub()

  before ->
    SocketService = require '../../../app/services/socket_service'
    socketService = new SocketService

  describe '#connect', ->

    before ->
      socketService.connect callbacks

    it 'should initialize a WebSocket', ->
      expect(socketService.socket).to.be.defined

    it 'should establish a WebSocket connection', ->
      location = window.location
      expect(io.connect).to.be.calledWith "#{location.protocol}//#{location.hostname}"

    it 'should register the given callbacks', ->
      registration = socketService.socket.on
      event    = 'connect'
      callback = callbacks[event]
      expect(registration).to.be.calledWith event, callback

  describe '#on', ->

    it 'should call the `on` method on the socket', ->
      event    = 'foo'
      callback = ->
      socketService.on event, callback
      expect(socketService.socket.on).to.be.calledWith event, callback
      socketService.socket.on.reset()

  describe '#emit', ->

    it 'should call the `emit` method on the socket', ->
      event    = 'foo'
      callback = ->
      socketService.emit event, callback
      expect(socketService.socket.emit).to.be.calledWith event, callback
      socketService.socket.emit.reset()
