angular.module 'flashSloth'

.controller "memberApplyMakeCtrl", [
  '$scope'
  'restAgent'
  'dialog'
  'fsv'
  'apply'
  (
    $scope
    restAgent
    dialog
    fsv
    apply
  ) ->
    if typeof(angular.translate) is 'function'
      $scope._ = angular.translate

    $scope.apply = apply
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