angular.module 'flashSloth'

.service 'g', ->
    self = @

    self.g = {}

    self.clear = ->
      self.g = {}

    self.clear()

    return self.g
