class Rate < ApplicationRecord
  include RateRepository

  belongs_to :currency

  delegate :abbr, :name, to: :currency
end
