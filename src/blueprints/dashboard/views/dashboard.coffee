angular.module 'flashSloth'

.controller "dashboardCtrl", [
  '$scope'
  'restAgent'
  'navService'
  (
    $scope
    restAgent
    navService
  ) ->
    navService.section('dashboard')
    $scope.status = restAgent.status.get()
]