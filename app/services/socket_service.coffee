io = require 'socket.io'

class SocketService

  connect: (@_callbacks = {}) ->
    @_setupConnection()
    @_registerCallbacks()
    @

  _setupConnection: ->
    DEFAULT_HOST    = "#{location.protocol}//#{location.hostname}"
    PRODUCTION_HOST = location.origin.replace /^https?/, 'ws'
    CLIENT_ENV      = 'test' if CLIENT_ENV is undefined
    host = if 'production' is CLIENT_ENV then PRODUCTION_HOST else DEFAULT_HOST
    socket = io.connect host,
      'port':                      location.port
      'reconnection delay':        100
      'reconnection limit':        2000
      'max reconnection attempts': 100
      'sync disconnect on unload': true

    @socket = socket

    if @env is 'development'
      socket.on 'connect', ->
        console.debug 'Socket.IO connected :-)'

      socket.on 'connecting', ->
        console.debug 'Socket.IO is trying to connect...'

      socket.on 'disconnect', ->
        console.debug 'Socket.IO disconnected :-('

      socket.on 'connect_failed', ->
        console.debug 'Socket.IO connect failed :-('

      socket.on 'reconnect', ->
        console.debug 'Socket.IO reconnected :D'

      socket.on 'reconnecting', ->
        console.debug 'Socket.IO is trying to reconnect...'

      socket.on 'reconnect_failed', ->
        console.debug 'Socket.IO reconnect failed x-('

      socket.on 'error', ->
        console.error 'Socket.IO error', @
    @

  _registerCallbacks: ->
    for event, callback of @_callbacks
      @socket.on event, callback
    @

  on: (event, callback) ->
    @socket.on event, callback

  emit: (event, data) ->
    @socket.emit event, data

module.exports = SocketService
