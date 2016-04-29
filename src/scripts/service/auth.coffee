angular.module 'flashSloth'

.service 'Auth', [
  '$cookies'
  'Config'
  (
    $cookies
    Config
  ) ->
    opts =
      path: '/'
      domain: Config.cookie_domain

    @is_logged = ->
      !!$cookies.get 'agent_auth'

    @token = ->
      $cookies.get 'agent_auth'

    @login = (token) ->
      $cookies.put 'agent_auth', token, opts

    @logout = ->
      $cookies.remove 'agent_auth', opts

    return
]