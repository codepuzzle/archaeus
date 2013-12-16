describe 'SocketService', ->

  socketService = null
  io            = null
  callbacks     = null

  before ->
    socketStub = sinon.stub().returns on: sinon.stub()
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
