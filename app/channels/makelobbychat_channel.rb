class MakelobbychatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "makelobbychat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
