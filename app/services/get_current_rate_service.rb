module GetCurrentRateService
  class << self
    def call(currency_abbr)
      Rate.for(currency_abbr).current
    end
  end
end
