require 'test_helper'

module Web
  module Public
    class CurrentRatePageTest < ActionDispatch::IntegrationTest
      def setup
        @currency = create(:currency, abbr: 'USD')
        @rate     = create(:regular_rate, currency: @currency)
      end

      def test_open_root_page
        visit root_path

        assert { page.has_css?('div.container') }
        assert { page.has_css?('div#current-rate') }
        assert { @rate.value.to_s == parsed_current_rate(page) }
      end

      def test_imported_new_rate
        visit root_path

        new_rate = create(:regular_rate, currency: @currency)

        sleep 1

        Notify::CurrentRateService.call(RateSerializer.new(new_rate))

        assert { new_rate.value.to_s == parsed_current_rate(page) }
      end
    end
  end
end
