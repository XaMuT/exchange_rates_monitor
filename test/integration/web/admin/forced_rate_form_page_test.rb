require 'test_helper'

module Web
  module Admin
    class ForcedRateFormPageTest < ActionDispatch::IntegrationTest
      def test_form_has_datetimepicker
        visit new_admin_forced_rate_path

        element = 'input.datetimepicker'
        widget  = 'div.bootstrap-datetimepicker-widget'

        assert { page.has_css?(element) }
        assert { page.has_no_css?(widget) }

        page.find(element).click

        assert { page.has_css?(widget) }
      end

      def test_created_new_forced_rate
        currency     = create(:currency, abbr: 'USD')
        regular_rate = create(:regular_rate, currency: currency)
        forced_rate  = build(:forced_rate, currency: currency)

        visit root_path

        assert { regular_rate.value.to_s == parsed_current_rate(page)}

        Capybara.using_session("admin session") do
          visit admin_root_path

          page.fill_in('Курс в рублях', with: forced_rate.value)
          page.execute_script("$('.datetimepicker').data('DateTimePicker').date('#{forced_rate.ends_at.strftime('%d.%m.%Y %H:%M')}')")
          page.click_button 'Сохранить форсированный курс'
        end

        assert { forced_rate.value.to_s == parsed_current_rate(page)}
      end
    end
  end
end
