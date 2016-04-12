angular.module 'flashSloth'

.controller "promoAgentCtrl", [
  '$scope'
  '$routeParams'
  '$filter'
  '$location'
  'restAgent'
  'flash'
  'Config'
  'fsv'
  'g'
  (
    $scope
    $routeParams
    $filter
    $location
    restAgent
    flash
    Config
    fsv
    g
  ) ->
    promo_sid = $routeParams.promo_sid
    agent_life = $routeParams.agent_life

    $scope.forms = {}
    $scope.input =
      code: ''
      count: 1

    $scope.codes = []
    $scope.pin = null
    $scope.activated = false
    $scope.promo_types = Config.promo_types

    $scope.agent_deadline = do ->
      if not agent_life
        return '????'
      deadline = $filter('dateformat')(
        agent_life * 1000,
        'yyyy-MM-dd H:mm'
      )
      return deadline


    $scope.promocode = {}

    $scope.promo_profile = new restAgent.promocode({
      sid: promo_sid
    })

    get_endtime = (remain)->
      if remain
        endtime = $filter('dateformat')(
          Date.now() + remain * 1000,
          'yyyy-MM-dd H:mm'
        )
      else
        endtime = null
      return endtime

    process_code = (code) ->
      return code

    check_badrequest = (error)->
      if not error
        return false
      if error.status == 403
        $location.path('/403')
        return true
      else
        return false

    $scope.activate = ->
      $scope.promo_profile.pin = $scope.pin
      $scope.promo_profile.$get()
      .then (data)->
        $scope.promo_profile.endtime = get_endtime(data.remain)
        $scope.activated = true
      .catch (error)->
        check_badrequest(error)

    $scope.reset = ->
      $scope.promocode = {}
      $scope.input = {}
      for k,v of $scope.forms
        v.$setPristine()
        v.$setUntouched()

    $scope.get = ->
      if not fsv($scope.forms.get_form, 'code')
        return
      $scope.promocode = new restAgent.promocode({
        code: process_code($scope.input.code)
        sid: promo_sid
        pin: $scope.pin
      })

      $scope.promocode.$get()
      .then (data)->
        $scope.promo_profile.endtime = get_endtime(data.remain)
        $scope.promo_profile.count = data.count
        $scope.promo_profile.common = data.common
      .catch (error)->
        check_badrequest(error)
        $scope.promocode._error = true

    $scope.use = ->
      if not fsv($scope.forms.use_form, 'code')
        return
      $scope.promocode = new restAgent.promocode({
        code: process_code($scope.input.code)
        sid: promo_sid
        pin: $scope.pin
      })
      $scope.promocode.$use()
      .then (data)->
        $scope.promo_profile.endtime = get_endtime(data.remain)
        $scope.promo_profile.count = data.count
        $scope.promo_profile.common = data.common
        flash 'Promo code has been used.'
      .catch (error)->
        check_badrequest(error)
        $scope.promocode._error = true

    reset_create_count = ->
      $scope.input.count = 1

    $scope.$watch 'input.count', (val)->
      if $scope.promo_profile.amount isnt null
        min = Math.min $scope.promo_profile.amount, val
        $scope.input.count = min

    $scope.batch_create = (create_count, retry)->
      amount = $scope.promo_profile.amount
      if amount isnt null
        create_count = Math.min amount, create_count
      if create_count <= 0
        return
      if retry is undefined
        retry = 0
      create(create_count, retry)
      .then ->
        create_count -= 1
        if create_count > 0
          $scope.batch_create(create_count, retry)
        else
          reset_create_count()
          flash 'Promo codes have been created.'
      .catch (error)->
        if error and retry < 1 and not check_badrequest(error)
          console.log 'retry:', retry
          retry += 1
          $scope.batch_create(create_count, retry)
      return

    create = ->
      new_promocode = new restAgent.promocode({
        sid: promo_sid
        pin: $scope.pin
      })
      new_promocode.$create()
      .then (data)->
        $scope.promo_profile.endtime = get_endtime(data.remain)
        $scope.promo_profile.count = data.count
        $scope.promo_profile.common = data.common
        $scope.promo_profile.amount = data.amount
        $scope.codes.push(data)


]