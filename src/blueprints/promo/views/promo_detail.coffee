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

    $scope.code = ''
    $scope.promo_code = null

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

    $scope.find_code = (code)->
      $scope.promo_code = new restAgent.promo_code
        promo_id: promo_id
        code: code

      $scope.promo_code.$get()
      .catch (error)->
        $scope.promo_code._error = true


]