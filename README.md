# Archaeus

Realtime collaborative rainbow eyecandy generator

http://archaeus.herokuapp.com

## Introduction

Archaeus is a symbolical interpretation of basic alchemical principles. Being a symbol, it's meaning is to be understood by heart and thus cannot be unveiled by pure intellect. Speaking clearly, it's up to you how much sense it makes and you will not find any interpretation written in here.

## Description

A visitor is represented by a *Soul* having a random color. The screen represents a *Grid* of *Cells*, which are initially uncolored and hold no Soul respectively. A Cell can *revive* by a Soul moving the mouse over the Grid. On revive, it holds the Soul and reflects its light by enduing its color.

So by moving the mouse the well-disposed reader already senses that you merely draw some squares with a randomly assigned color on the screen.

Once other Souls stumble over Archaeus and start reviving Cells, they instantly sense each others activity by the individual colors on the screen. And when a Soul revives a Cell which already holds another Soul, the Grid around this Cell ablazes in a shedload of rainbow colors.

## Implementation

Archaeus is a Javascript implementation, written in Coffeescript – and proudly and thankfully uses the following libraries:

- *Brunch* as build tool
  http://brunch.io
- *Color* for color conversion
  https://npmjs.org/package/color
- *Backbone* for Views and Events
  http://backbonejs.org
- *NodeJS* on the Serverside
  http://nodejs.org
- *Socket.io* to handle realtime-communication
  http://socket.io
- *Mocha.js* Test Framework
  http://visionmedia.github.io/mocha
- *Karma* Test runner
  http://karma-runner.github.io

Archaeus is happy to be running on http://heroku.com

### Folder and File Description

```
/archaeus
  ├ /src                             - Domain Models
  │ ├ /effects                       - Color effects
  │ │ ├ mix_colors.coffee
  │ │ ├ rotate_colors.coffee
  │ │ └ swap_colors.coffee
  │ │ 
  │ ├ cell.coffee
  │ ├ grid.coffee
  │ └ soul.coffee
  │
  ├ /app                             - Application files
  │ ├ /assets                        - Static assets
  │ │ └ index.html                   - The main HTML file
  │ │
  │ ├ /services                      - Services
  │ │ └ socket_service.coffee        - WebSocket Adapter
  │ │
  │ ├ /views                         - Backbone Views
  │ │ ├ cell_view.coffee
  │ │ └ grid_view.coffee
  │ │
  │ └ app.coffee                     - The main app file
  │
  ├ /server
  │ └ server.coffee                  - Node.JS and Socket.IO Server Runner
  │
  ├ /spec                            - Specs / Tests according to app and src files
  │ ├ /app
  │ │ ├ /services
  │ │ │ └ socket_service_spec.coffee
  │ │ │
  │ │ ├ /views
  │ │ │ ├ cell_view_spec.coffee
  │ │ │ └ grid_view_spec.coffee
  │ │ │
  │ │ └ app_spec.coffee
  │ │
  │ ├ /archaeus
  │ │ ├ /effects
  │ │ │ └ swap_colors_spec.coffee
  │ │ │ 
  │ │ ├ cell_spec.coffee
  │ │ ├ grid_spec.coffee
  │ │ └ soul_spec.coffee
  │ │
  │ ├ /server
  │ │
  │ └ spec_helper.coffee             - Test-runner bootstrap code
  │
  ├ /vendor                          - Unbundled vendor libraries
  ├ Makefile                         - Setup and Run scripts
  ├ README.md                        - This README
  ├ package.json                     - Project package description
  ├ bower.json                       - Frontend dependencies description
  ├ brunch-config.coffee             - Build description
  └ karma.conf.coffee                - Test runner description
```

### Caveats and known issues

Archaeus is currently under development. The implementation is tested only in Chrome on Mac OS X so far.

## Copyright

Copyright (c) 2014 Anton Mikulcic. Licensed under GNU General Public License.
