angular.module 'flashSloth'

.config [
  '$routeProvider'
  (
    $routeProvider
  ) ->
    bp = "card"
    dir = "blueprints/card/views"

    $routeProvider
    .when '/'+bp,
      templateUrl: dir+'/cards.html'
      controller: 'cardsCtrl'

    $routeProvider
    .when '/'+bp+'/:card_id',
      templateUrl: dir+'/card_detail.html'
      controller: 'cardDetailCtrl'

]