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
    $scope.locales = Config.locales

    $scope.showMenu = ->
      return $mdMedia('gt-md')

    $scope.toggleNav = (nav) ->
      $mdSidenav(nav).toggle()

    $scope.is_current_lang = (locale) ->
      current = supLocales.get()
      return supLocales.match(locale.code, current)

    $scope.use_lang = (locale) ->
      supLocales.set(locale.code)
      $route.reload()

    $scope.exit = ->
      g.clear()
      $scope.navs.clear()
      Auth.logout()

    $scope.go = (route)->
      if route
        $location.path route

]
