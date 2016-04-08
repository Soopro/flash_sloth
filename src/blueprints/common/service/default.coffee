angular.module 'flashSloth'

.factory 'navDefault', [
  'navService'
  (
    navService
  )->
    default_navs = [
      {
        alias: "portal"
        name: "Portal"
        path: "/"
        ico: "ic_layers_24px"
      }
      {
        alias: "promo"
        name: "Promotions"
        ico: "ic_local_play_24px"
      }
      {
        alias: "events"
        name: "Events"
        ico: "ic_event_24px"
        path: "/crm/events"
      }
      {
        alias: "member"
        name: "Membership"
        ico: "ic_people_24px"
        path: "/member"
      }
    ]

    @load =  ->
      navs = angular.copy(default_navs)
      navService.load(navs)

    return @
]