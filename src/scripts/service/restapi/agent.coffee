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

    # -- Member --
    member: do ->
      supResource "#{api}/member"

    member_apply: do ->
      supResource "#{api}/member/applyment"

    # -- Events --
    activity: do ->
      supResource "#{api}/member/activity/:alias",
        'alias':'@alias'

    # -- Promo --
    promo: do ->
      supResource "#{api}/promo"

    promocode: do ->
      supResource "#{api}/promo/code/:code",
        'code':'@code'

]
