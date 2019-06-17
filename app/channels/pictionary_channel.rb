class PictionaryChannel < ApplicationCable::Channel
  def subscribed
    stream_from "pictionary_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
