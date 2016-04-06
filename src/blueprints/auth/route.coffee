angular.module 'flashSloth'

.config [
  '$routeProvider'
  (
    $routeProvider
  ) ->
    bp = "auth"
    dir = "blueprints/auth/views"

    $routeProvider
    .when '/'+bp,
      templateUrl: dir+'/check_in.html'
      controller: 'checkInCtrl'

    return
]