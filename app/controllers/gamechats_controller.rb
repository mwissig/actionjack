class GamechatsController < ApplicationController
  before_action :get_gamechats

  def index
  end

  def new
  end

  def create
          if logged_in?
    @gamechat = @current_user.gamechats.build(gamechat_params)
    if @gamechat.save
      ActionCable.server.broadcast 'makegamechat_channel',
                                   body:  @gamechat.body,
                                   username: @gamechat.user.profile.username,
                                   color: @gamechat.user.profile.color,
                                   game: @gamechat.game_type,
                                   id: @gamechat.game_id
     end
    end
  end

  private

    def get_gamechats
      @gamechats = Lobbychat.all
      if logged_in?
        @gamechat = @current_user.gamechats.build(gamechat_params)
        @gamechat.user_id = @current_user.id
    end
    end

    def gamechat_params
      params.require(:gamechat).permit(:body, :game_id, :game_type)
    end
end
