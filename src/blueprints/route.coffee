angular.module('url4cc').config [
  '$routeProvider'
  (
    $routeProvider
  ) ->
    'use strict'
    $routeProvider
    .when('/404', templateUrl: 'blueprints/404.html')

    .otherwise redirectTo: '/404'

    return
]