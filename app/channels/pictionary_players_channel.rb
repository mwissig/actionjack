class PictionaryPlayersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "pictioanry_players_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
