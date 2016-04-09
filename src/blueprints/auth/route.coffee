angular.module 'flashSloth'

.config [
  '$routeProvider'
  (
    $routeProvider
  ) ->
    dir = "blueprints/auth/views"

    $routeProvider
    .when '/auth',
      templateUrl: dir+'/check_in.html'
      controller: 'checkInCtrl'

    $routeProvider
    .when '/exit',
      template: ''
      controller: 'exitCtrl'

    return
]