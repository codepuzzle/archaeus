_ = require 'underscore'

require('fs').readdirSync(__dirname).forEach (file) ->
  module.exports = _.extend require("./#{file}"), module.exports
