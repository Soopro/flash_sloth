angular.module 'flashSloth'

.config [
  '$routeProvider'
  (
    $routeProvider
  ) ->
    bp = "event"
    dir = "blueprints/event/views"

    $routeProvider
    .when '/'+bp,
      templateUrl: dir+'/events.html'
      controller: 'eventsCtrl'

    $routeProvider
    .when '/'+bp+'/:act_id',
      templateUrl: dir+'/event_detail.html'
      controller: 'eventDetailCtrl'

]