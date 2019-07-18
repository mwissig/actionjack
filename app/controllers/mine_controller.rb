class MineController < ApplicationController
  def move
    @current_player = @current_user.mineplayer
    @deltax = params[:movedeltax]
    @deltay = params[:movedeltay]
    @coords = params[:movecoords]
    p @coords
    p "=============================="
    if logged_in?
      @current_player.deltax = @deltax
      @current_player.deltay = @deltay
      @current_player.coords = @coords
      @current_player.save!
          redirect_to mine_path
    end
  end

  def dig
  end

  def place
  end
end
