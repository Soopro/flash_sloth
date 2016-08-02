angular.module 'flashSloth'

.factory 'restAgent', [
  'supResource'
  'Config'
  (
    supResource
    Config
  ) ->
    api = "#{Config.baseURL.api}/crm/agent"

    # -- Auth --
    auth: do ->
      supResource "#{api}/check_in"

    # -- Status --
    status: do ->
      supResource "#{api}/status"

    # -- Member --
    member: do ->
      supResource "#{api}/member/:member_id",
        'member_login': '@login'
        'member_id': '@id'

    member_demand: do ->
      supResource "#{api}/member/:member_id/demand/:demand_id",
        'member_id': '@member_id'
        'demand_id': '@id'
      ,
        done: method: "POST"

    # -- Events --
    event: do ->
      supResource "#{api}/event/:event_id",
        'event_id': '@id'

    demand: do ->
      supResource "#{api}/event/:event_id/demand/:demand_id",
        'event_id': '@event_id'
        'demand_id': '@id'
      ,
        done: method: "POST"

    # -- Promo --
    promo: do ->
      supResource "#{api}/promo/:promo_id",
        'promo_id': '@id'

    promocode: do ->
      supResource "#{api}/promo/:promo_id/code/:code",
        'promo_id': '@id'
        'code':'@code'
      ,
        use: method: "POST"

]
