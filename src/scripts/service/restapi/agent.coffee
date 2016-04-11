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
      supResource "#{api}/member"

    member_apply: do ->
      supResource "#{api}/member/applyment"

    # -- Events --
    activity: do ->
      supResource "#{api}/activity/:act_id",
        'act_id': '@id'

    applyment: do ->
      supResource "#{api}/activity/:act_id/applyment/:apply_id",
        'act_id': '@activity_id'
        'apply_id': '@id'

    # -- Promo --
    promo: do ->
      supResource "#{api}/promo"

    promocode: do ->
      supResource "#{api}/promo/code/:code",
        'code':'@code'

]
