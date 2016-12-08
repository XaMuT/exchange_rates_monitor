class CurrentRateChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'current_rate_channel'
  end
end
