angular.module 'flashSloth'

.controller "exitCtrl", [
  '$scope'
  '$location'
  'Auth'
  'Config'
  'g'
  (
    $scope
    $location
    Auth
    Config
    g
  ) ->
    g.$clear()
    Auth.logout()
    $location.path Config.route.auth

]