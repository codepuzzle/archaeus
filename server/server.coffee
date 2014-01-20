path     = require 'path'
socketIO = require 'socket.io'

class Server

  PUBLIC_FOLDER_PATH = path.resolve __dirname, '..', 'public'

  run: ->
    @_initHttpServer()
    @_initSocketIO()
    @

  _initHttpServer: ->
    express = require 'express'

    @app = express()
    @app.use express.static PUBLIC_FOLDER_PATH

    @app.get "/", (req, res) ->
      res.sendfile path.resolve PUBLIC_FOLDER_PATH, 'index.html'

    @server = require("http").createServer @app

    @server.listen process.env.PORT or 5000

    @

  _initSocketIO: ->
    @io = io = socketIO.listen @server

    io.configure ->
      # TODO Use socketIO.RedisStore in production
      io.set 'store', new socketIO.MemoryStore

    io.configure 'production', ->
      io.enable 'browser client etag'
      io.enable 'browser client minification'
      io.enable 'browser client gzip'
      io.set 'log level', 1
      io.set 'transports', [ 'websocket', 'flashsocket', 'htmlfile', 'xhr-polling', 'jsonp-polling' ]

    io.configure 'development', ->
      io.set 'transports', [ 'websocket' ]

    io.sockets.on 'error', (err) ->
      console.error 'ERROR (Socket.IO)', err

    io.sockets.on 'connection', (socket) ->
      socket.on 'cell:change', (data) ->
        socket.broadcast.emit 'cell:change', data
    @

module.exports = Server

if require.main is module
  server = new Server
  server.run()
