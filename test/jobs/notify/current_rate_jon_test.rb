require 'test_helper'

module Notify
  class CurrentRateJobTest < ActiveJob::TestCase
    def setup
      @currency = create(:currency, abbr: 'USD', cbrf_code: 'R01235')
      create(:regular_rate, currency: @currency)
    end

    def test_perform
      perform_enqueued_jobs do
        Notify::CurrentRateJob.perform_later(@currency.abbr)
      end

      assert { performed_jobs.one? }
    end
  end
end
