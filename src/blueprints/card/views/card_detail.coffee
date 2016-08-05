angular.module 'flashSloth'

.controller "cardDetailCtrl", [
  '$scope'
  '$routeParams'
  '$location'
  '$filter'
  'restAgent'
  'QRScanner'
  'flash'
  'dialog'
  'Config'
  'ConfigCard'
  'fsv'
  (
    $scope
    $routeParams
    $location
    $filter
    restAgent
    QRScanner
    flash
    dialog
    Config
    ConfigCard
    fsv
  ) ->
    card_id = $routeParams.card_id
    code = $routeParams.code

    $scope.code = code
    $scope.promo_loaded = false
    $scope.code_loaded = false
    $scope.submitted = false
    $scope.gen_mode = false
    $scope.promocode = {}
    $scope.new_codes = []
    $scope.add_point = 0

    $scope.cardstyles = ConfigCard.cardstyles

    $scope.card = restAgent.card.get
      card_id: card_id


    $scope.disable_use = (card)->
      type_point = $scope.promo_type_point($scope.promocode.type)

      if $scope.promocode.consumed
        return true
      else if $scope.promocode.status != 1
        return true
      else if $scope.promocode.member_assigned and not $scope.member_login
        return true
      else if type_point and not $scope.add_point
        return true
      else if $scope.promo.common
        timeout = $scope.promo.remain isnt null and $scope.promo.remain <= 0
        runout = $scope.promo.amount isnt null and $scope.promo.amount <= 0
        return timeout or runout
      else
        return false


    $scope.has_scanner = QRScanner.check()

    $scope.scan_code = ->
      if not $scope.has_scanner or $scope.submitted
        return
      $scope.submitted = true

      QRScanner.scan()
      .then (data)->
        if data.result
          if angular.startswith(data.result, Config.baseURL.self)
            path = data.result.replace(Config.baseURL.self, '')
            $location path
          else
            $scope.code = data.result
            $scope.submitted = false
            $scope.find_code(true)
          return
      .catch (error)->
        console.error error
      .finally ->
        $scope.submitted = false


    $scope.find_code = (skip_form)->
      if not fsv($scope.find_form, ['code']) and not skip_form
        return
      if $scope.submitted
        return
      $scope.submitted = true
      $scope.promocode = new restAgent.promocode
        id: promo_id
        code: $scope.code

      $scope.promocode.$get()
      .catch (error)->
        $scope.promocode =
          _error: true
      .finally ->
        $scope.code_loaded = true
        $scope.submitted = false

    $scope.reset_code = ->
      $scope.code = null
      $scope.promocode = {}
      $scope.find_form.$setPristine()
      $scope.find_form.$setUntouched()

    $scope.switch_gen_mode = (mode)->
      $scope.gen_mode = mode


    $scope.use_code = ->
      if $scope.submitted
        return
      $scope.submitted = true
      $scope.promocode.member_login = $scope.member_login
      $scope.promocode.add_point = $scope.add_point
      $scope.add_point = 0
      $scope.promocode.$use()
      .then (data)->
        $scope.promocode._success = true
        $scope.promo.amount = data.amount
        $scope.promo.duration = data.duration
        $scope.promo.remain = data.remain
        $scope.promo.count = data.count
        flash 'Promo code has been used.'
        return
      .catch (error)->
        $scope.promocode._error = true
      .finally ->
        $scope.submitted = false


    $scope.create = ->
      if $scope.submitted
        return
      $scope.submitted = true
      create_one($scope.assign_member_login)
      .then ->
        flash 'Promo code has been created.'
        return
      .finally ->
        $scope.submitted = false

    $scope.auto_create = ->
      $scope.assign_member_login = null

      if $scope.submitted
        return
      $scope.submitted = true
      dialog.show
        controller: 'batchCreateCodeCtrl'
        templateUrl: 'blueprints/promo/views/batch_create_code.tmpl.html'
        fullscreen: false
      .then (create_count)->
        batch_create(create_count)
      .then ->
        flash 'Promo codes have been created.'
        return
      .finally ->
        $scope.submitted = false


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
          batch_create(create_count, 0)
      .catch (error)->
        if error and retry < 1
          console.log 'retry:', retry
          retry += 1
          batch_create(create_count, retry)
      return


    create_one = (member_login)->
      new_promocode = new restAgent.promocode
        id: promo_id
        member_login: member_login

      new_promocode.$create()
      .then (data)->
        data.member_login = member_login
        $scope.new_codes.push(data)
        $scope.promo.count = data.count

]