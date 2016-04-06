angular.module('url4cc')

.constant('Config', {
  'baseURL': {
    'api': sup_ext_url4cc.server.api
  },
  
  'cookie_domain': sup_ext_url4cc.cookie_domain,
  
  'debug': sup_ext_url4cc.is_debug,
  
  'route': {
    portal: '/forward',
    auth: '/auth',
    error: '/404',
  },
  
})
