require 'test_helper'

module Import
  class RateJobTest < ActiveJob::TestCase
    def setup
      @currency = create(:currency, abbr: 'USD', cbrf_code: 'R01235')
    end

    def test_perform
      VCR.use_cassette('daily_import') do
        assert_enqueued_with(job: Notify::CurrentRateJob, args: [@currency.abbr]) do
          Import::RateJob.perform_now('2016-11-24')
        end

        assert { @currency.rates.one? }
      end
    end
  end
end
