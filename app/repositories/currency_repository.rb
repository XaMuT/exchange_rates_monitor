module CurrencyRepository
  extend ActiveSupport::Concern

  included do
    scope :by_abbr, -> (abbr) { where(abbr: abbr) }
  end
end
