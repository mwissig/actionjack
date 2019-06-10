class LobbychatsController < ApplicationController
  before_action :get_lobbychats

  def index
  end

  def create
    @lobbychat = Lobbychat.new(lobbychat_params)
    if @lobbychat.save
      ActionCable.server.broadcast 'makelobbychat_channel',
                                   body:  @lobbychat.body
     end
  end

  private

    def get_lobbychats
      @lobbychats = Lobbychat.all
      @lobbychat = Lobbychat.new
    end

    def post_params
      params.require(:post).permit(:body)
    end
end
