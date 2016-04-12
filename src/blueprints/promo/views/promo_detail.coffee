angular.module 'flashSloth'

.controller "promoDetailCtrl", [
  '$scope'
  '$routeParams'
  '$filter'
  'restAgent'
  'flash'
  'ConfigPromo'
  'fsv'
  'g'
  (
    $scope
    $routeParams
    $filter
    restAgent
    flash
    ConfigPromo
    fsv
    g
  ) ->
    promo_id = $routeParams.promo_id

    $scope.promo = restAgent.promo.get
      promo_id: promo_id

    $scope.remain = (remain)->
      if remain
        endtime = $filter('dateformat')(
          Date.now() + remain * 1000,
          'yyyy-MM-dd H:mm'
        )
      else
        endtime = null
      return endtime

    $scope.promo_type_name = (ptype)->
      for type in ConfigPromo.promo_types
        if type.key == ptype
          return type.name
      return null

]