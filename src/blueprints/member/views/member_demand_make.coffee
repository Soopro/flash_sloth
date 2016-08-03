angular.module 'flashSloth'

.controller "memberDemandMakeCtrl", [
  '$scope'
  'restAgent'
  'dialog'
  'fsv'
  'demand'
  (
    $scope
    restAgent
    dialog
    fsv
    demand
  ) ->
    if typeof(angular.translate) is 'function'
      $scope._ = angular.translate

    $scope.demand = demand
    $scope.submitted = false

    $scope.events = []

    $scope.loadEvents = ->
      $scope.events = restAgent.event.query()

    $scope.save = ->
      if not fsv($scope.create_form, ['event'])
        return
      if $scope.submitted
        return
      $scope.submitted = true
      $scope.demand.$save()
      .then (data) ->
        dialog.hide(data)
      .finally ->
        $scope.submitted = false

    $scope.close = ->
      dialog.cancel()

]