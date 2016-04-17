angular.module 'flashSloth'

.constant 'Config',
  baseURL:
    'api': sup_flash_sloth.server.api
    'self': sup_flash_sloth.server.self

  cookie_domain: sup_flash_sloth.cookie_domain

  debug: sup_flash_sloth.debug

  route:
    portal: '/'
    auth: '/auth'
    exit: '/exit'
    error: '/404'

  locales: [
    { code:'en_US', text:'English'}
    { code:'zh_CN', text:'简体中文'}
  ]

  default_locale: 'en_US'

  path:
    outer: [
      '/auth'
    ]
    open: [
      '/404'
      '/403'
    ]