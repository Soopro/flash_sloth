angular.module 'flashSloth'

.config [
  '$routeProvider'
  (
    $routeProvider
  ) ->
    bp = "member"
    dir = "blueprints/member/views"

    $routeProvider
    .when '/'+bp,
      templateUrl: dir+'/member.html'
      controller: 'memberCtrl'

]