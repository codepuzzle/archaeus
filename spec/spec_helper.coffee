chai = require 'chai'

sinonChai = require 'sinon-chai'
chai.use sinonChai

global.expect = chai.expect
global.sinon  = require 'sinon'
global.path   = require 'path'
global._      = require 'underscore'
