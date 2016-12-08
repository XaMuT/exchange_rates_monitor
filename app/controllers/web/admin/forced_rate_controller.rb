module Web
  module Admin
    class ForcedRateController < Web::Admin::BaseController
      def new
        last_forced_rate = Rate::ForcedRate.last
        last_forced_rate_attributes = last_forced_rate ? last_forced_rate.attributes : nil

        @forced_rate_form = Web::Admin::ForcedRateForm.new(last_forced_rate_attributes)
      end

      def create
        @forced_rate_form = Web::Admin::ForcedRateForm.new(forced_rate_params)

        if @forced_rate_form.save!
          Notify::CurrentRateService.call(RateSerializer.new(@forced_rate_form.model))
          Notify::CurrentRateJob.set(wait_until: @forced_rate_form.model.ends_at).perform_later(current_currency.abbr)

          redirect_to new_admin_forced_rate_path
        else
          render :new
        end
      end

      private

      def forced_rate_params
        params.require(:web_admin_forced_rate_form).permit(:value, :ends_at).merge(currency_id: current_currency.id)
      end
    end
  end
end
