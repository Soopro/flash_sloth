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
      templateUrl: dir+'/gate.html'
      controller: 'memberGateCtrl'

    $routeProvider
    .when '/'+bp+'/:member_id',
      templateUrl: dir+'/member_detail.html'
      controller: 'memberDetailCtrl'

]