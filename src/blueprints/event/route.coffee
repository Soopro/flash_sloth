angular.module 'flashSloth'

.config [
  '$routeProvider'
  (
    $routeProvider
  ) ->
    bp = "event"
    dir = "blueprints/event/views"

    $routeProvider
    .when '/'+bp+'/list',
      templateUrl: dir+'/events.html'
      controller: 'eventsCtrl'

    $routeProvider
    .when '/'+bp+'/detail/:event_id',
      templateUrl: dir+'/event_detail.html'
      controller: 'eventDetailCtrl'

]