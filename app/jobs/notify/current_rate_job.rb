module Notify
  class CurrentRateJob < ApplicationJob
    def perform(currency_abbr)
      current_rate = GetCurrentRateService.call(currency_abbr)

      Notify::CurrentRateService.call(RateSerializer.new(current_rate).as_json)
    end
  end
end
