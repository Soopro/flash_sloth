angular.module 'flashSloth'

.controller "promosCtrl", [
  '$scope'
  '$location'
  'restAgent'
  (
    $scope
    $location
    restAgent
  ) ->
    $scope.promos = restAgent.promo.query()

    $scope.open = (promo)->
      $location.path '/promo/'+promo.id
]