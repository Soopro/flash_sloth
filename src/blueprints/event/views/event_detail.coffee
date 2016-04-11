angular.module 'flashSloth'

.controller "eventDetailCtrl", [
  '$scope'
  '$routeParams'
  'restAgent'
  'flash'
  'Config'
  'fsv'
  'g'
  (
    $scope
    $routeParams
    restAgent
    flash
    Config
    fsv
    g
  ) ->
    act_id = $routeParams.act_id
    $scope.event = restAgent.activity.get
      act_id: act_id
]