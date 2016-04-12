angular.module 'flashSloth'

.controller "promoDetailCtrl", [
  '$scope'
  '$routeParams'
  '$filter'
  'restAgent'
  'flash'
  'dialog'
  'ConfigPromo'
  'fsv'
  'g'
  (
    $scope
    $routeParams
    $filter
    restAgent
    flash
    dialog
    ConfigPromo
    fsv
    g
  ) ->
    promo_id = $routeParams.promo_id

    $scope.code = null
    $scope.promo_loaded = false
    $scope.code_loaded = false
    $scope.gen_mode = false
    $scope.promocode = {}
    $scope.new_codes = []

    $scope.promo = new restAgent.promo
      id: promo_id

    $scope.promo.$get()
    .then (data)->
      $scope.promo_loaded = true
      if $scope.promo.common
        $scope.code = $scope.promo.alias
        $scope.find_code(true)

    $scope.remain = (remain)->
      if remain
        endtime = $filter('dateformat')(
          Date.now() + remain * 1000,
          'yyyy-MM-dd H:mm'
        )
      else
        endtime = null
      return endtime

    $scope.promo_type_name = (ptype)->
      for type in ConfigPromo.promo_types
        if type.key == ptype
          return type.name
      return null

    $scope.disable_use = ->
      if $scope.promocode.status != 0
        return true
      else
        if $scope.promo.common
          timeout = $scope.promo.remain isnt null and $scope.promo.remain <= 0
          runout = $scope.promo.amount isnt null and $scope.promo.amount <= 0
          return timeout or runout
        if $scope.promocode.consumed
          return true


    $scope.find_code = (skip_form)->
      if not fsv($scope.find_form, ['code']) and not skip_form
        return
      $scope.promocode = new restAgent.promocode
        id: promo_id
        code: $scope.code

      $scope.promocode.$get()
      .catch (error)->
        $scope.promocode =
          _error: true
      .finally ->
        $scope.code_loaded = true

    $scope.reset_code = ->
      $scope.code = null
      $scope.promocode = {}
      $scope.find_form.$setPristine()
      $scope.find_form.$setUntouched()

    $scope.switch_gen_mode = (mode)->
      $scope.gen_mode = mode


    $scope.use_code = ->
      $scope.promocode.$use()
      .then (data)->
        $scope.promocode._success = true
        $scope.promo.amount = data.amount
        $scope.promo.duration = data.duration
        $scope.promo.remain = data.remain
        $scope.promo.count = data.count
        flash 'Promo code has been used.'
      .catch (error)->
        $scope.promocode =
          _error: true


    $scope.create = ->
      create_one($scope.assign_member_log)
      .then ->
        flash 'Promo code has been created.'
      return

    $scope.auto_create = ->
      dialog.show
        controller: 'batchCreatePromoCodeCtrl'
        templateUrl: 'blueprints/promo/views/promo_code_batch.tmpl.html'
      .then (data)->
        batch_create(data.create_count)
      .then ->
        flash 'Promo code has been created.'
      return


    batch_create = (create_count, retry)->
      amount = $scope.promo.amount
      if amount isnt null
        create_count = Math.min amount, create_count
      if create_count <= 0
        return
      if retry is undefined
        retry = 0
      create_one()
      .then ->
        create_count -= 1
        if create_count > 0
          batch_create(create_count, retry)
        else
          flash 'Promo codes have been created.'
      .catch (error)->
        if error and retry < 1
          console.log 'retry:', retry
          retry += 1
          batch_create(create_count, retry)
      return


    create_one = (member_log)->
      new_promocode = new restAgent.promocode
        id: promo_id
        member_log: member_log

      new_promocode.$create()
      .then (data)->
        data.member_log = member_log
        $scope.new_codes.push(data)
        $scope.promo.count = data.count

]