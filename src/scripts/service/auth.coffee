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
      !!$cookies.get 'agent_auth'

    @token = ->
      $cookies.get 'agent_auth'

    @login = (token, next_path) ->
      $cookies.put 'agent_auth', token, opts
      $location.path next_path if next_path

    @logout = ->
      $cookies.remove 'agent_auth', opts
      $location.path '/auth'

    return
]