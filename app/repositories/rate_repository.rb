module RateRepository
  extend ActiveSupport::Concern

  included do
    scope :by_date, ->                 { order(:date) }
    scope :by_id,   ->                 { order(:id) }
    scope :for,     -> (currency_abbr) { joins(:currency).merge(Currency.by_abbr(currency_abbr)) }
  end

  class_methods do
    def current
      now   = Time.zone.now
      today = now.to_date

      by_id.where('rates.created_at <= :now AND rates.ends_at >= :now', now: now).last || by_date.where('rates.date <= ?', today).last
    end
  end
end
