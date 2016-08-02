angular.module 'flashSloth'

.controller "eventsCtrl", [
  '$scope'
  '$location'
  'restAgent'
  (
    $scope
    $location
    restAgent
  ) ->

    $scope.events = restAgent.event.query()

    $scope.open = (event)->
      $location.path '/event/'+event.id

]