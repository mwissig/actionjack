class MineController < ApplicationController
  def move
    @current_player = @current_user.mineplayer
    @deltax = params[:movedeltax]
    @deltay = params[:movedeltay]
    @coords = params[:movecoords]
    if logged_in?
      @current_player.deltax = @deltax
      @current_player.deltay = @deltay
      @current_player.coords = @coords
      @current_player.save!
      if @current_player.save
        ActionCable.server.broadcast 'mineplayer_channel',
                    id: @current_player.user_id,
                    deltax: @current_player.deltax,
                    deltay: @current_player.deltay,
                    coords: @current_player.coords
      end
      redirect_to mine_path
    end
  end

  def dig
  end

  def place
  end
end
