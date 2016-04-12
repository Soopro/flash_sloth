angular.module 'flashSloth'

.controller "memberApplyEditCtrl", [
  '$scope'
  'dialog'
  'restAgent'
  'apply'
  (
    $scope
    dialog
    restAgent
    apply
  ) ->
    if typeof(angular.translate) is 'function'
      $scope._ = angular.translate

    $scope.apply = restAgent.applyment.get
      act_id: apply.activity_id
      apply_id: apply.id

    $scope.submitted = false

    $scope.done = ->
      if $scope.submitted
        return
      $scope.submitted = true
      $scope.apply.$done()
      .then (data) ->
        dialog.hide(data)

    $scope.save = ->
      if $scope.submitted
        return
      $scope.submitted = true
      $scope.apply.$save()
      .then (data) ->
        dialog.hide(data)

    $scope.close = ->
      dialog.cancel()

]