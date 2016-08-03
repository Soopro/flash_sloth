angular.module 'flashSloth'

.controller "memberDemandEditCtrl", [
  '$scope'
  'dialog'
  'demand'
  (
    $scope
    dialog
    demand
  ) ->
    if typeof(angular.translate) is 'function'
      $scope._ = angular.translate

    $scope.demand = demand

    $scope.submitted = false

    $scope.done = ->
      if $scope.submitted
        return
      $scope.submitted = true
      $scope.demand.$done()
      .then (data) ->
        dialog.hide(data)
      .finally ->
        $scope.submitted = false

    $scope.save = ->
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