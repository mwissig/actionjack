class LobbychatsController < ApplicationController
  before_action :get_lobbychats

  def index
  end

  def new
  end

  def create
          if logged_in?
    @lobbychat = @current_user.lobbychats.build(lobbychat_params)
    if @lobbychat.save
      ActionCable.server.broadcast 'makelobbychat_channel',
                                   body:  @lobbychat.body,
                                   username: @lobbychat.user.profile.username,
                                   color: @lobbychat.user.profile.color
     end
    end
  end

  private

    def get_lobbychats
      @lobbychats = Lobbychat.all
      if logged_in?
        @lobbychat = @current_user.lobbychats.build(lobbychat_params)
        @lobbychat.user_id = @current_user.id
    end
    end

    def lobbychat_params
      params.require(:lobbychat).permit(:body)
    end
end
