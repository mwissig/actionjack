class TictactoeChannel < ApplicationCable::Channel
  def subscribed
    stream_from "tictactoe_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
