angular.module 'flashSloth'

.controller "memberDetailCtrl", [
  '$scope'
  '$routeParams'
  '$location'
  'restAgent'
  'flash'
  'Config'
  'fsv'
  'g'
  (
    $scope
    $routeParams
    $location
    restAgent
    flash
    Config
    fsv
    g
  ) ->
    member_id = $routeParams.member_id

    $scope.submitted = false

    $scope.member = new restAgent.member.get
      member_id: member_id

]