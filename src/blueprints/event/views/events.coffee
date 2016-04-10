angular.module 'flashSloth'

.controller "eventsCtrl", [
  '$scope'
  '$routeParams'
  '$filter'
  '$location'
  'restAgent'
  'navService'
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
    navService
    flash
    Config
    fsv
    g
  ) ->
    navService.section('events')

    $scope.events = restAgent.activity.query()
    $scope.open = (activity)->
      $location.path '/event/'+activity.id

]