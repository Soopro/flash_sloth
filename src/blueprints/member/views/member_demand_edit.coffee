angular.module 'flashSloth'

.controller "memberApplyEditCtrl", [
  '$scope'
  'dialog'
  'apply'
  (
    $scope
    dialog
    apply
  ) ->
    if typeof(angular.translate) is 'function'
      $scope._ = angular.translate

    $scope.apply = apply

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