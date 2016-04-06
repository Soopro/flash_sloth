angular.module 'flashSloth'

.config [
  '$routeProvider'
  'gResolveProvider'
  (
    $routeProvider
    gResolveProvider
  ) ->
    bp = "agent"
    dir = "blueprints/agent/views"
    resolve =
      global: gResolveProvider.resolve

    $routeProvider
    .when '/',
      templateUrl: dir+'/portal.html'
      controller: 'portalCtrl'
      resolve: resolve

    return
]