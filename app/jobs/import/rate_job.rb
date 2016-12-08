module Import
  class RateJob < ApplicationJob
    def perform(date_str)
      Currency.find_each do |currency|
        Import::RateService.call(currency, date_str)
      end

      Notify::CurrentRateJob.perform_later(Rails.configuration.container[:current_currency_abbr])
    end
  end
end
