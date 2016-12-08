require_relative './boot'
require_relative './environment'
require 'clockwork'

module Clockwork
  every(1.day, 'Import rates for tomorrow', at: '23:00') do
    tomorrow = Date.current + 1
    Import::RateJob.perform_later(tomorrow.to_s)
  end
end
