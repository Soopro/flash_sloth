angular.module 'flashSloth'

.service 'Auth', [
  '$cookies'
  '$location'
  'Config'
  (
    $cookies
    $location
    Config
  ) ->
    opts =
      path: '/'
      domain: Config.cookie_domain

    @is_logged = ->
      !!$cookies.get 'promo'

    @token = ->
      $cookies.get 'promo'

    @login = (token, next_path) ->
      $cookies.put 'promo', token, opts
      $location.path next_path if next_path
      return

    @logout = ->
      $cookies.remove 'promo', opts
      $location.path '/auth'
      return

    return
]