angular.module 'flashSloth'

.service 'g', [
  'restAgent'
  'supChain'
  (
    restAgent
    supChain
  ) ->
    class Promo
      constructor: ->
        @profile = null
      set_profile: (profile) ->
        @profile = profile
      init: ->
        self = @
        restAgent.promo.get (data) ->
          self.set_profile data
          console.log 'Promo profile loaded'
        .$promise

    self = @

    @init = ->
      self.clear()
      console.info '------ Flash Sloth: Loading Global Datas ------'
      supChain()
      .then ->
        self.promo.init()
      .then ->
        self.inited = true
        console.info '------------ Flash Sloth: Loaded ------------'
      .catch (error) ->
        console.error error

    @clear = ->
      self.inited = false
      self.promo = new Promo

    @clear()

    @
]
