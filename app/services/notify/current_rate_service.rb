module Notify
  class CurrentRateService
    class << self
      def call(rate)
        ActionCable.server.broadcast 'current_rate_channel', message: rate
      end
    end
  end
end
