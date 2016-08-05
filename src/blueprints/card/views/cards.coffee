angular.module 'flashSloth'

.controller "cardsCtrl", [
  '$scope'
  '$location'
  'restAgent'
  (
    $scope
    $location
    restAgent
  ) ->
    $scope.cards = restAgent.card.query()

    $scope.open = (card)->
      $location.path '/card/'+card.id
]