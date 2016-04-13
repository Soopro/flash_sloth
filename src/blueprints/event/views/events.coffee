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

    $scope.events = restAgent.activity.query()

    $scope.open = (activity)->
      $location.path '/event/'+activity.id

]