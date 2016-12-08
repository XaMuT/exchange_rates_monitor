require 'test_helper'

module Web
  module Public
    class CurrentRateControllerTest < ActionDispatch::IntegrationTest
      def setup
        @currency = create(:currency, abbr: 'USD')
        create(:regular_rate, currency: @currency)
      end

      def test_show_with_empty_rate
        Rate.destroy_all

        get root_path

        assert_response :success
      end

      def test_show_with_regular_rate
        get root_path

        assert_response :success
      end

      def test_show_with_forced_rate
        create(:forced_rate, currency: @currency, ends_at: '2016-11-24T12:00:00Z', created_at: '2016-11-24T06:00:00Z')

        travel_to DateTime.parse('2016-11-24T11:00:00Z') do
          get root_path

          assert_response :success
        end
      end
    end
  end
end

