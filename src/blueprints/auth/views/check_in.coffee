angular.module 'flashSloth'

.controller "checkInCtrl", [
  '$scope'
  'restAgent'
  'Auth'
  'flash'
  'Config'
  'fsv'
  (
    $scope
    restAgent
    Auth
    flash
    Config
    fsv
  ) ->
    $scope.auth = {}
    $scope.submitted = false

    $scope.submit = ->
      if not fsv($scope.auth_form, ['pin'])
        return
      $scope.submitted = true
      restAgent.auth.post $scope.auth, (data)->
        $scope.submitted = false
        Auth.login data.token, '/'

]