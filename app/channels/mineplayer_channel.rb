class MineplayerChannel < ApplicationCable::Channel
  def subscribed
    stream_from "mineplayer_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
