angular.module 'flashSloth'

.config [
  '$routeProvider'
  (
    $routeProvider
  ) ->
    bp = "portal"
    dir = "blueprints/portal/views"

    $routeProvider
    .when '/',
      templateUrl: dir+'/portal.html'
      controller: 'portalCtrl'

]