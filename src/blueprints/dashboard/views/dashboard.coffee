angular.module 'flashSloth'

.controller "dashboardCtrl", [
  '$scope'
  'restAgent'
  (
    $scope
    restAgent
  ) ->
    $scope.status = restAgent.status.get()
]