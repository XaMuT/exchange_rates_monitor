class Currency < ApplicationRecord
  include CurrencyRepository

  has_many :rates,         dependent: :destroy
  has_many :regular_rates, class_name: 'Rate::RegularRate'
  has_many :forced_rates,  class_name: 'Rate::ForcedRate'

  alias_attribute :code, :cbrf_code
end
