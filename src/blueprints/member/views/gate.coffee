angular.module 'flashSloth'

.controller "memberGateCtrl", [
  '$scope'
  '$location'
  'restAgent'
  'fsv'
  (
    $scope
    $location
    restAgent
    fsv
  ) ->
    $scope.submitted = false

    $scope.member = new restAgent.member()
    $scope.new = new restAgent.member({
      entrypoint: 'CRM Agent Tool'
    })

    $scope.find_member = ->
      if not fsv($scope.find_member_form, ['login'])
        return
      if $scope.submitted
        return
      $scope.submitted = true
      $scope.member.$get()
      .then (data)->
        $location.path 'member/'+data.id
      .finally ->
        $scope.submitted = false

    $scope.new_member = ->
      if not fsv($scope.new_member_form, ['login', 'name', 'mobile', 'email'])
        return
      if $scope.submitted
        return
      $scope.submitted = true
      $scope.new.$save()
      .finally ->
        $scope.submitted = false
]