angular.module 'flashSloth'

.controller "memberCtrl", [
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
    $scope.member = null

    $scope.find_member = ->
      if not fsv($scope.member_form, ['log'])
        return
      $scope.member = restAgent.member.get
        member_log: $scope.log
]