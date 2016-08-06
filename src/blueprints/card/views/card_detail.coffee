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

    $scope.submitted = false

    $scope.gen_mode = false
    $scope.display_card = {}
    $scope.generated = []

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
      QRScanner.scan()
      .then (data)->
        if data.result
          if angular.startswith(data.result, Config.baseURL.self)
            path = data.result.replace(Config.baseURL.self, '')
            $location path
          else
            $scope.code = data.result
            $scope.find_code(true)
          return
      .catch (error)->
        console.error error


    $scope.find_code = (skip_form)->
      return if $scope.submitted
      if not fsv($scope.find_form, ['code']) and not skip_form
        return

      $scope.submitted = true
      $scope.display_card = new restAgent.cardnum
        card_id: card_id
        code: $scope.code

      $scope.display_card.$get()
      .catch (error)->
        $scope.display_card =
          _error: true
      .finally ->
        $scope.submitted = false

    $scope.reset_code = ->
      $scope.code = null
      $scope.display_card = {}
      $scope.find_form.$setPristine()
      $scope.find_form.$setUntouched()

    $scope.switch_gen_mode = (mode)->
      $scope.gen_mode = mode


    $scope.use = (display_card)->
      if $scope.submitted
        return
      $scope.submitted = true
      display_card.member_login = $scope.member_login
      display_card.balance = $scope.add_point

      display_card.$use()
      .then (data)->
        $scope.add_point = 0
        display_card._success = true
        $scope.card.amount = data.amount
        $scope.card.duration = data.duration
        $scope.card.count = data.count
        flash 'Card has been used.'
        return
      .catch (error)->
        display_card._error = true
      .finally ->
        $scope.submitted = false


    $scope.create = ->
      if $scope.submitted
        return
      $scope.submitted = true
      create_one($scope.assign_member_login)
      .then ->
        flash 'Card has been created.'
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
        templateUrl: 'blueprints/card/views/batch_create_code.tmpl.html'
        fullscreen: false
      .then (create_count)->
        batch_create(create_count)
      .then ->
        flash 'Cards have been created.'
        return
      .finally ->
        $scope.submitted = false


    batch_create = (create_count, retry)->
      amount = $scope.card.amount
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
      cardnum = new restAgent.cardnum
        card_id: card_id
        member_login: member_login

      cardnum.$create()
      .then (data)->
        data.member_login = member_login
        $scope.card.count = data.count
        $scope.generated.push(data)

]