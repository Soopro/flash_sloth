angular.module 'flashSloth'

.controller "promosCtrl", [
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