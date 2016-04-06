angular.module 'flashSloth'

.provider 'gResolve', ->
  resolve: [
    'g'
    (
      g
    ) ->
      if not g.inited
        g.init()
  ]

  $get: ->