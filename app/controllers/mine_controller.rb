class MineController < ApplicationController
  def move
    ActionCable.server.broadcast 'mineplayer_channel',
      playerid: params[:playerid],
      deltax: params[:deltax],
      deltay: params[:deltay],
      coords: params[:coords]
    head :ok

    @user = User.find_by(id: params[:playerid])
    @player = @user.mineplayer
    @deltax = params[:deltax]
    @deltay = params[:deltay]
    @coords = params[:coords]
    @player.deltax = @deltax
    @player.deltay = @deltay
    @player.coords = @coords
    @player.save!

  end

  def dig
  end

  def place
  end
end
