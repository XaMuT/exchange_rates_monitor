require 'test_helper'

module Web
  module Admin
    class ForcedRateControllerTest < ActionDispatch::IntegrationTest
      include ActiveJob::TestHelper

      def setup
        @currency = create(:currency, abbr: 'USD')
      end

      def test_new
        get new_admin_forced_rate_path

        assert_response :success
      end

      def test_create_with_error
        post admin_forced_rate_path, params: { web_admin_forced_rate_form: { value: 1, ends_at: '1986-08-31' } }

        assert_response :success
      end

      def test_create
        forced_rate_attributes = attributes_for(:forced_rate)

        assert_enqueued_with(job: Notify::CurrentRateJob, args: [@currency.abbr], at: forced_rate_attributes[:ends_at].to_i) do
          post admin_forced_rate_path, params: { web_admin_forced_rate_form: forced_rate_attributes }
        end

        assert_redirected_to new_admin_forced_rate_path
      end
    end
  end
end
