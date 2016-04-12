angular.module 'flashSloth'

.controller "promoDetailCtrl", [
  '$scope'
  '$routeParams'
  '$filter'
  '$location'
  'restAgent'
  'flash'
  'Config'
  'fsv'
  'g'
  (
    $scope
    $routeParams
    $filter
    $location
    restAgent
    flash
    Config
    fsv
    g
  ) ->
    $scope.status = restAgent.status.get()
]