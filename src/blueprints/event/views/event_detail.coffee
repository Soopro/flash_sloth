angular.module 'flashSloth'

.controller "eventDetailCtrl", [
  '$scope'
  '$routeParams'
  'restAgent'
  'dialog'
  'flash'
  'Config'
  'fsv'
  'g'
  (
    $scope
    $routeParams
    restAgent
    dialog
    flash
    Config
    fsv
    g
  ) ->
    act_id = $routeParams.act_id
    paged = 0
    last_index = 0
    $scope.has_more = false
    $scope.total = 0

    process_paged = (list)->
        if list.length > 0
          last_data = list[list.length-1]
          last_index = last_data.cursor.index
          $scope.total = last_data.cursor.total
          $scope.has_more = last_data.cursor.index < last_data.cursor.total-1

    $scope.event = restAgent.activity.get
      act_id: act_id

    $scope.applyments = restAgent.applyment.query
      act_id: act_id
    , (data) ->
      process_paged(data)

    $scope.open = (apply)->
      dialog.show
        controller: 'applyEditCtrl'
        templateUrl: 'blueprints/event/views/apply_edit.tmpl.html'
        locals:
          apply: apply


    $scope.more = ->
      paged++
      restAgent.applyment.query
        act_id: act_id
        offset: last_index+1
      , (list) ->
        process_paged(list)
        for item in list
          $scope.applyments.push item

]