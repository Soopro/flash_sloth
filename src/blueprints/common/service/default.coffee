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
        ico: "maps:ic_directions_walk_24px"
      }
      {
        alias: "apps"
        name: "Apps"
        ico: "nav:ic_apps_24px"
        nodes:[
          {
            alias: "create"
            name: "Create New"
            path: "/create_app"
            class: "md-primary"
          }
        ]
      }
      {
        alias: "crm"
        name: "Membership"
        ico: "social:ic_people_24px"
        nodes:[
          {
            alias: "members"
            name: "Members"
            path: "/crm/members"
          }
          {
            alias: "roles"
            name: "Member Roles"
            path: "/crm/roles"
          }
          {
            alias: "events"
            name: "Events"
            path: "/crm/events"
          }
          {
            alias: "promos"
            name: "Promo Codes"
            path: "/crm/promos"
          }
          {
            alias: "agent"
            name: "CRM Agent"
            path: "/crm/agent"
          }
        ]
      }
      {
        alias: "addons"
        name: "Marketplace"
        ico: "action:ic_extension_24px"
        nodes:[
          {
            alias: "store"
            name: "Themes & Exts"
            path: "/store"
          }
          {
            alias: "purchased"
            name: "Purchased Items"
            path: "/store/purchased"
          }
        ]
      }
      {
        alias: "account"
        name: "Account"
        ico: "action:ic_settings_24px"
        nodes:[
          {
            alias: "profile"
            name: "Profile"
            path: "/user/profile"
          }
          {
            alias: "security"
            name: "Security"
            path: "/user/security"
          }
          {
            alias: "invite"
            name: "Invite Codes"
            path: "/user/invite"
            class: "md-primary"
          }
        ]
      }
    ]

    @load = (apps, limit) ->
      navs = angular.copy(default_navs)
      apps =
        if angular.isArray(apps)
        then angular.copy(apps).reverse()
        else []

      for nav in navs
        if nav.alias is 'apps'
          if apps.length >= limit
            nav.nodes = []
          for app in apps
            nav.nodes.unshift({
              alias: app.alias
              name: app.title
              path: app.type+'/'+app.alias
              app_id: app.id
            })
          break
      navService.load(navs)

    return @
]