class MinemapChannel < ApplicationCable::Channel
  def subscribed
    stream_from "minemap_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
