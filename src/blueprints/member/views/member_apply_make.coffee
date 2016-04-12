angular.module 'flashSloth'

.controller "memberApplyMakeCtrl", [
  '$scope'
  'restAgent'
  'dialog'
  'apply'
  (
    $scope
    restAgent
    dialog
    apply
  ) ->
    if typeof(angular.translate) is 'function'
      $scope._ = angular.translate

    $scope.apply = apply
    $scope.submitted = false

    $scope.events = []

    $scope.loadEvents = ->
      $scope.events = restAgent.activity.query()

    $scope.save = ->
      if $scope.submitted
        return
      $scope.submitted = true
      $scope.apply.$save()
      .then (data) ->
        dialog.hide(data)
      .finally ->
        $scope.submitted = false

    $scope.close = ->
      dialog.cancel()

]