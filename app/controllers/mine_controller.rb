class MineController < ApplicationController
  def move

    ActionCable.server.broadcast 'mineplayer_channel',
      playerid: params[:playerid],
      deltax: params[:deltax],
      deltay: params[:deltay],
      coords: params[:coords]
    head :ok

  @range = (1..5).to_a
  @chance = @range.sample
    if @chance == 1
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
  end

  def dig
    ActionCable.server.broadcast 'minemap_channel',
      coords: params[:coords],
      changefrom: params[:changefrom],
      changeto: params[:changeto]
    head :ok
    @tile = Minetile.find_by(coords: params[:coords])
    @tile.fgclass = params[:changeto]
    @tile.save!
  end

  def place
    ActionCable.server.broadcast 'minemap_channel',
      coords: params[:coords],
      changefrom: params[:changefrom],
      changeto: params[:changeto]
    head :ok
    @tile = Minetile.find_by(coords: params[:coords])
    @tile.fgclass = params[:changeto]
    @tile.save!
  end
end
