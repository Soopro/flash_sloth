angular.module('url4cc').config [
  '$routeProvider'
  (
    $routeProvider
  ) ->
    'use strict'
    $routeProvider.when('/', redirectTo: '/auth').when('/404', templateUrl: 'blueprints/404.html').otherwise redirectTo: '/404'
    return
]