angular.module 'flashSloth'

.factory 'restAgent', [
  'supResource'
  'Config'
  (
    supResource
    Config
  ) ->
    api = "#{Config.baseURL.api}/crm/agent"

    # -- Promo --
    promo: do ->
      supResource "#{api}/promo/:agent_id",
        'agent_id':'@id'

    # -- PromoCode --
    promocode: do ->
      supResource "#{api}/promocode/:agent_id",
        'agent_id':'@id'

]

