angular.module 'flashSloth'

.controller "memberGateCtrl", [
  '$scope'
  '$location'
  'restAgent'
  'flash'
  'fsv'
  (
    $scope
    $location
    restAgent
    flash
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

    $scope.create_member = ->
      fields = ['login', 'passwd', 'name', 'mobile', 'email']
      if not fsv($scope.new_member_form, fields)
        return
      if $scope.submitted
        return
      $scope.submitted = true
      $scope.new.$save()
      .then (data)->
        $scope.new_member_form.$setPristine()
        $scope.new_member_form.$setUntouched()
        $location.path 'member/'+data.id
        flash 'Member has been created.'
      .finally ->
        $scope.submitted = false
]