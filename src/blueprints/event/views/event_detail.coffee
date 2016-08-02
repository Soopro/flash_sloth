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
    event_id = $routeParams.event_id
    paged = 0
    last_index = 0
    $scope.has_more = false
    $scope.total = 0

    process_paged = (list)->
      if list.length > 0
        last_data = list[list.length-1]
        last_index = last_data.cursor.index
        $scope.total = last_data.cursor.total
        $scope.has_more = last_index < $scope.total-1

    $scope.event = restAgent.event.get
      event_id: event_id

    $scope.demands = restAgent.demand.query
      event_id: event_id
    , (data) ->
      process_paged(data)

    $scope.open = (demand)->
      dialog.show
        controller: 'demandEditCtrl'
        templateUrl: 'blueprints/event/views/demand_edit.tmpl.html'
        locals:
          demand: demand
      .then (data)->
        if data.status isnt 1
          last_index-=1
          $scope.total-=1
          angular.removeFromList($scope.demands, data, 'id')
          flash "Demand has been closed."
        else
          flash "Demand has been saved."
        return

    $scope.more = ->
      paged++
      restAgent.demand.query
        event_id: event_id
        offset: last_index+1
      , (list) ->
        process_paged(list)
        for item in list
          $scope.demands.push item

]