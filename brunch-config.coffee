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

        'js/vendor.js': (path) ->
          required = [
            'bower_components(?!/commonjs-require)'
            'vendor/backbone'
            'vendor/color/color.js'
            'vendor/color-convert/index.js'
            'vendor/color-convert/conversions.js'
            'vendor/color-string/color-string.js'
          ]
          required = new RegExp '^' + required.join('|')
          required.test path

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

      # the color library, which is now under vendor, aswell
      path = path.replace /^vendor\/color.*\/(.*\/)?/, ''
      path = path.replace /^vendor\/color-convert/, 'color-convert'

      path
