angular.module 'flashSloth'

.controller "checkInCtrl", [
  '$scope'
  '$location'
  '$routeParams'
  'restAgent'
  'Auth'
  'flash'
  'Config'
  'fsv'
  (
    $scope
    $location
    $routeParams
    restAgent
    Auth
    flash
    Config
    fsv
  ) ->
    $scope.auth =
      passcode: ''
      owner_slug:  ''

    $scope.submitted = false

    $scope.submit = ->
      if not fsv($scope.auth_form, ['owner', 'passcode']) or $scope.submitted
        return

      $scope.submitted = true
      do_auth = new restAgent.auth($scope.auth)
      do_auth.$post()
      .then (data)->
        Auth.login data.token
        $location.path '/'
      .finally ->
        $scope.submitted = false

]