angular.module 'flashSloth'

.factory 'requestInterceptor', [
  '$q'
  '$cookies'
  '$location'
  'flashMsgStack'
  'Auth'
  'Config'
  (
    $q
    $cookies
    $location
    flashMsgStack
    Auth
    Config
  ) ->
    request: (request) ->
      request.headers = request.headers or {}
      if $cookies.get('auth') and not request.headers.Authorization
        request.headers.Authorization = "Bearer #{$cookies.get 'auth'}"
      request

    response: (response) ->
      response or $q.when(response)

    responseError: (rejection) ->
      is_api_reject = angular.startswith(rejection.config.url,
                                         Config.baseURL.api)
      if not is_api_reject
        console.log ('Request is rejected by remote.')
      else
        if rejection.status is 0 and rejection.data is null
          $location.path("/404")
          msg = 'Error! No connection to server.'
          flashMsgStack.set
            text: msg
            warn: true
        if rejection.status is 401
          # handle the case where the user is not Authenticated
          Auth.logout()
        if rejection.data and rejection.data.errmsg \
        and rejection.status isnt 200
          flashMsgStack.set
            text: rejection.data.errmsg
            warn: true
          console.apiError rejection.data

      $q.reject rejection
]

.config [
  '$httpProvider'
  (
    $httpProvider
  ) ->
    # add interceptors to request
    $httpProvider.interceptors.push 'requestInterceptor'
    # add X-Requested-With
    common = $httpProvider.defaults.headers.common
    common["X-Requested-With"] = 'XMLHttpRequest'
]