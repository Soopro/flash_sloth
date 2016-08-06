angular.module 'flashSloth'

.controller "memberDetailCtrl", [
  '$scope'
  '$routeParams'
  'restAgent'
  'supChain'
  'dialog'
  'flash'
  (
    $scope
    $routeParams
    restAgent
    supChain
    dialog
    flash
  ) ->
    member_id = $routeParams.member_id
    paged = 0
    last_index = 0
    $scope.has_more = false
    $scope.total = 0

    $scope.submitted = false

    process_paged = (list)->
      if list.length > 0
        last_data = list[list.length-1]
        last_index = last_data.cursor.index
        $scope.total = last_data.cursor.total
        $scope.has_more = last_data.cursor.index < last_data.cursor.total-1

    supChain()
    .then ->
      $scope.member = restAgent.member.get
        member_id: member_id
      $scope.member.$promise
    .then ->
      $scope.member_cards = restAgent.member_cards.query
        member_id: member_id
      $scope.member_cards.$promise
    .then ->
      $scope.demands = restAgent.member_demand.query
        member_id: member_id
      , (list)->
        process_paged(list)


    $scope.accept_member = (member)->
      $scope.submitted = true
      member.$activate()
      .then ->
        flash "Member has been reviewed."
      .finally ->
        $scope.submitted = false


    $scope.make_demand = ->
      demand_tmpl =
        member_id: member_id
      demand = new restAgent.member_demand(demand_tmpl)
      dialog.show
        controller: 'memberDemandMakeCtrl'
        templateUrl: 'blueprints/member/views/member_demand_make.tmpl.html'
        locals:
          demand: demand
      .then (data)->
        last_index+=1
        $scope.total+=1
        $scope.demands.unshift data
      .then (data)->
        flash "Demand has been created."


    $scope.open = (demand)->
      dialog.show
        controller: 'memberDemandEditCtrl'
        templateUrl: 'blueprints/member/views/member_demand_edit.tmpl.html'
        locals:
          demand: demand
      .then (data)->
        if data.status isnt 1
          flash "Demand has been closed."
        else
          flash "Demand has been saved."
        return


    $scope.more = ->
      paged++
      restAgent.member_demand.query
        member_id: member_id
        offset: last_index+1
      , (list) ->
        process_paged(list)
        for item in list
          $scope.demands.push item

]