require 'test_helper'

module Import
  class RateServiceTest < ActiveSupport::TestCase
    def setup
      @currency    = build(:currency, cbrf_code: 'R01235')
      @starts_from = '2016-11-22'
      @ends_to     = '2016-11-25'
    end

    def test_call
      VCR.use_cassette("cbrf") do
        Import::RateService.call(@currency, @starts_from, @ends_to)

        assert { 4 == @currency.regular_rates.size }
      end
    end
  end
end
