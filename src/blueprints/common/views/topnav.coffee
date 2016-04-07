angular.module 'flashSloth'

.controller 'topNavCtrl', [
  '$scope'
  '$route'
  '$location'
  '$mdSidenav'
  '$mdMedia'
  'Config'
  'Auth'
  'supLocales'
  'navService'
  'g'
  (
    $scope
    $route
    $location
    $mdSidenav
    $mdMedia
    Config
    Auth
    supLocales
    navService
    g
  ) ->
    $scope.navs = navService

    init_g = ->
      $scope.profile = g.user.profile

    if not g.inited
      $scope.g = g
      unwatch = $scope.$watch "g.inited"
      , (inited)->
        if inited
          init_g()
          unwatch()
    else
      init_g()

    $scope.locales = Config.locales

    $scope.showMenu = ->
      return $mdMedia('gt-md')

    $scope.toggleNav = (nav)->
      $mdSidenav(nav).toggle()

    $scope.is_current_lang = (locale) ->
      current = supLocales.get()
      return supLocales.match(locale.code, current)

    $scope.use_lang = (locale) ->
      supLocales.set(locale.code)
      $route.reload()

    $scope.logout = ->
      restUser.doLogout()
      .then ->
        g.clear()
        $scope.navs.clear()
        Auth.logout()

    $scope.go = (route)->
      if route
        $location.path route

]
