module Web
  module Public
    class CurrentRateController < Web::Public::BaseController
      def show
        current_rate = GetCurrentRateService.call(current_currency.abbr)

        @serialized_current_rate = if current_rate
                          RateSerializer.new(current_rate).as_json
                        else
                          {}
                        end
      end
    end
  end
end
