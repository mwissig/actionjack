class MakegamechatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "makegamechat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
