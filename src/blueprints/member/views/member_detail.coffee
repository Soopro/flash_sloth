angular.module 'flashSloth'

.controller "memberDetailCtrl", [
  '$scope'
  '$routeParams'
  '$location'
  'restAgent'
  'dialog'
  'flash'
  'Config'
  'fsv'
  'g'
  (
    $scope
    $routeParams
    $location
    restAgent
    dialog
    flash
    Config
    fsv
    g
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

    $scope.member = restAgent.member.get
      member_id: member_id


    init_applyments = ->
      paged = 0
      last_index = 0
      $scope.has_more = false
      $scope.total = 0

      $scope.applyments = restAgent.member_apply.query
        member_id: member_id
      , (list)->
        process_paged(list)

    init_applyments()


    $scope.make_applyment = ->
      apply_tmpl =
        member_id: member_id
      apply = new restAgent.member_apply(apply_tmpl)
      dialog.show
        controller: 'memberApplyMakeCtrl'
        templateUrl: 'blueprints/member/views/member_apply_make.tmpl.html'
        locals:
          apply: apply
      .then ->
        init_applyments()
      .then (data)->
        flash "Reservation has been created."


    $scope.open = (apply)->
      dialog.show
        controller: 'memberApplyEditCtrl'
        templateUrl: 'blueprints/member/views/member_apply_edit.tmpl.html'
        locals:
          apply: apply
      .then (data)->
        if data.status isnt 0
          flash "Reservation has been closed."
          return
        else
          flash "Reservation has been saved."
          return


    $scope.more = ->
      paged++
      restAgent.member_apply.query
        member_id: member_id
        offset: last_index+1
      , (list) ->
        process_paged(list)
        for item in list
          $scope.applyments.push item

]