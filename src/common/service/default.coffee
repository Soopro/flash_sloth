angular.module 'flashSloth'

.factory 'navDefault', [
  'navService'
  (
    navService
  )->
    default_navs = [
      {
        key: "dashboard"
        name: "Dashboard"
        path: "/"
        ico: "ic_dashboard_24px"
      }
      {
        key: "member"
        name: "Membership"
        ico: "ic_people_24px"
        path: "/member"
      }
      {
        key: "events"
        name: "Events"
        ico: "ic_event_24px"
        path: "/event"
      }
      {
        key: "card"
        name: "Cards"
        ico: "ic_local_play_24px"
        path: "/card"
      }
      {
        key: "exit"
        name: "Exit"
        ico: "ic_exit_24px"
        path: "/exit"
      }
    ]

    @load =  ->
      navs = angular.copy(default_navs)
      navService.load(navs)

    return @
]