angular.module 'flashSloth'

.controller "eventsCtrl", [
  '$scope'
  '$routeParams'
  '$filter'
  '$location'
  'restAgent'
  'flash'
  'Config'
  'fsv'
  'g'
  (
    $scope
    $routeParams
    $filter
    $location
    restAgent
    flash
    Config
    fsv
    g
  ) ->
    $scope.events = restAgent.activity.query()
    $scope.open = (activity)->
      $location.path '/event/'+activity.id

]