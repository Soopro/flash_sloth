angular.module 'flashSloth'

.config [
  '$routeProvider'
  (
    $routeProvider
  ) ->
    bp = "promo"
    dir = "blueprints/promo/views"

    $routeProvider
    .when '/'+bp,
      templateUrl: dir+'/promos.html'
      controller: 'promosCtrl'

    $routeProvider
    .when '/'+bp+'/:promo_id',
      templateUrl: dir+'/promo_detail.html'
      controller: 'promoDetailCtrl'

]