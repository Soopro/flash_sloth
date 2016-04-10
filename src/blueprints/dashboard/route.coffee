angular.module 'flashSloth'

.config [
  '$routeProvider'
  (
    $routeProvider
  ) ->
    bp = "dashboard"
    dir = "blueprints/dashboard/views"

    $routeProvider
    .when '/',
      templateUrl: dir+'/dashboard.html'
      controller: 'dashboardCtrl'

]