angular.module 'flashSloth'

.controller "batchCreateCodeCtrl", [
  '$scope'
  'dialog'
  (
    $scope
    dialog
  ) ->
    if typeof(angular.translate) is 'function'
      $scope._ = angular.translate

    $scope.count = 1

    $scope.create = ->
      dialog.hide($scope.count)

    $scope.close = ->
      dialog.cancel()

]