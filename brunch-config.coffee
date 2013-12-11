exports.config =

  modules:
    definition: false
    wrapper:    false

  conventions:
    # wrap bower_components into commonjs
    vendor: -> false

  paths:
    watched: [
      'src',
      'app',
      'vendor'
    ]

  files:
    javascripts:
      joinTo:
        'js/app.js':    /^(src|app)/
        'js/vendor.js': /^vendor|(bower_components\/(zepto|underscore|color|color-convert|color-convert\/conversions|color-string))/
      order:
        before: [
          'bower_components/zepto.js',
          'bower_components/underscore.js',
          'vendor/backbone.view.js'
        ]

  plugins:
    jade:
      options:
        pretty: yes

  modules:
    nameCleaner: (path) ->
      # make index files available as e.g. require('effects')
      # instead of require('effects/index')
      path = path.replace /\/index\.(js|coffee)$/, ''

      # make bower components available as e.g. require('underscore')
      # instead of require('bower_componens/underscore/underscore')
      path = path.replace /^bower_components\/(.*\/)?/, ''

      path
