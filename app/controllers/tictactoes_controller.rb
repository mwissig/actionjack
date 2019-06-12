class TictactoesController < ApplicationController
    before_action :find_tictactoe, only: %i[show edit update a1 a2 a3 b1 b2 b3 c1 c2 c3]
    def new
      @tictactoe = Tictactoe.new
      if logged_in?
      @random_opponent = User.where.not(id: @current_user.id).sample
    end
  end

    def create
      @tictactoe = Tictactoe.new(tictactoe_params)
      if @tictactoe.save
            redirect_to tictacto_path(@tictactoe)
      else
        render 'new'
        msg = @tictactoe.errors.full_messages
  flash.now[:error] = msg
      end
    end

  def edit
  end

  def index
    @tictactoes = Tictactoe.all
    @tictactoe = Tictactoe.new
    if logged_in?
    @random_opponent = User.where.not(id: @current_user.id).sample
  end

  end

  def show
    @lobbychats = Lobbychat.all.last(200)
    if logged_in?
          @lobbychat = @current_user.lobbychats.new
        end
    @winner ||= ""

if @tictactoe.a1 == @tictactoe.b1 && @tictactoe.b1 == @tictactoe.c1
	@winner == @tictactoe.a1
end
if @tictactoe.a2 == @tictactoe.b2 && @tictactoe.b2 == @tictactoe.c2
	@winner == @tictactoe.a2
end
if @tictactoe.a3 == @tictactoe.b3 && @tictactoe.b3 == @tictactoe.c3
	@winner == @tictactoe.a3
end
if @tictactoe.a1 == @tictactoe.a2 && @tictactoe.a2 == @tictactoe.a3
	@winner == @tictactoe.a1
end
if @tictactoe.b1 == @tictactoe.b2 && @tictactoe.b2 == @tictactoe.b3
	@winner == @tictactoe.b1
end
if @tictactoe.c1 == @tictactoe.c2 && @tictactoe.c2 == @tictactoe.c3
	@winner == @tictactoe.c1
end
if @tictactoe.a1 == @tictactoe.b2 && @tictactoe.b2 == @tictactoe.c3
	@winner == @tictactoe.a1
end
if @tictactoe.a3 == @tictactoe.b2 && @tictactoe.b2 == @tictactoe.c1
	@winner == @tictactoe.a3
end
if @tictactoe.a1 != nil && @tictactoe.a2 != nil && @tictactoe.a3 != nil && @tictactoe.b1 != nil && @tictactoe.b2 != nil && @tictactoe.b3 != nil && @tictactoe.c1 != nil && @tictactoe.c2 != nil && @tictactoe.c3 != nil && @winner == ""
  @winner = "none"
end
if @winner != ""
  @tictactoe.a1 = nil
  @tictactoe.a2 = nil
  @tictactoe.a3 = nil
  @tictactoe.b1 = nil
  @tictactoe.b2 = nil
  @tictactoe.b3 = nil
  @tictactoe.c1 = nil
  @tictactoe.c2 = nil
  @tictactoe.c3 = nil
p @winner
      flash[:tictactoe] = @winner + "wins"
      if @winner = "x"
        @tictactoe.increment!(:x_wins, 1)
        User.find_by(id: @tictactoe.x_id).increment!(:points, 10)
        @tictactoe.turn = "x"
        flash[:tictactoe] = @winner + "wins"
      end
        if @winner = "o"
          @tictactoe.increment!(:o_wins, 1)
        User.find_by(id: @tictactoe.o_id).increment!(:points, 10)
                @tictactoe.turn = "o"
                flash[:tictactoe] = @winner + "wins"
        end
          @tictactoe.save!
        end
  end

  def a1
    if logged_in?
    if @tictactoe.x_id == @current_user.id
      if @tictactoe.turn == "x"
        if @tictactoe.a1 == nil
    @tictactoe.a1 = "x"
    @tictactoe.turn = "o"
    @tictactoe.save!
    if @tictactoe.save
       ActionCable.server.broadcast 'tictactoe_channel',
                              a1: @tictactoe.a1
    end
      else
    flash[:tictactoe] = "not valid move"
      end
    else
      flash[:tictactoe] = "not your turn"
    end
  elsif @tictactoe.o_id == @current_user.id
          if @tictactoe.turn == "o"
          if @tictactoe.a1 == nil
    @tictactoe.a1 = "o"
    @tictactoe.turn = "x"
    @tictactoe.save!
    ActionCable.server.broadcast 'tictactoe_channel'
                           a1: @tictactoe.a1
 end
  else
flash[:tictactoe] = "not valid move"
  end
    else
    flash[:tictactoe] = "not your turn"
    end
    end
    end
    redirect_to tictacto_path(@tictactoe)
  end

  def a2
    if logged_in?
    if @tictactoe.x_id == @current_user.id
      if @tictactoe.turn == "x"
        if @tictactoe.a2 == nil
    @tictactoe.a2 = "x"
    @tictactoe.turn = "o"
    @tictactoe.save!
      else
    flash[:tictactoe] = "not valid move"
      end
    else
      flash[:tictactoe] = "not your turn"
    end
  elsif @tictactoe.o_id == @current_user.id
          if @tictactoe.turn == "o"
          if @tictactoe.a2 == nil
    @tictactoe.a2 = "o"
    @tictactoe.turn = "x"
    @tictactoe.save!
  else
flash[:tictactoe] = "not valid move"
  end
    else
    flash[:tictactoe] = "not your turn"
    end
    end
    end
    redirect_to tictacto_path(@tictactoe)
  end

  def a3
    if logged_in?
    if @tictactoe.x_id == @current_user.id
      if @tictactoe.turn == "x"
        if @tictactoe.a3 == nil
    @tictactoe.a3 = "x"
    @tictactoe.turn = "o"
    @tictactoe.save!
      else
    flash[:tictactoe] = "not valid move"
      end
    else
      flash[:tictactoe] = "not your turn"
    end
  elsif @tictactoe.o_id == @current_user.id
          if @tictactoe.turn == "o"
          if @tictactoe.a3 == nil
    @tictactoe.a3 = "o"
    @tictactoe.turn = "x"
    @tictactoe.save!
  else
flash[:tictactoe] = "not valid move"
  end
    else
    flash[:tictactoe] = "not your turn"
    end
    end
    end
    redirect_to tictacto_path(@tictactoe)
  end

  def b1
    if logged_in?
    if @tictactoe.x_id == @current_user.id
      if @tictactoe.turn == "x"
        if @tictactoe.b1 == nil
    @tictactoe.b1 = "x"
    @tictactoe.turn = "o"
    @tictactoe.save!
      else
    flash[:tictactoe] = "not valid move"
      end
    else
      flash[:tictactoe] = "not your turn"
    end
  elsif @tictactoe.o_id == @current_user.id
          if @tictactoe.turn == "o"
          if @tictactoe.b1 == nil
    @tictactoe.b1 = "o"
    @tictactoe.turn = "x"
    @tictactoe.save!
  else
flash[:tictactoe] = "not valid move"
  end
    else
    flash[:tictactoe] = "not your turn"
    end
    end
    end
    redirect_to tictacto_path(@tictactoe)
  end

  def b2
    if logged_in?
    if @tictactoe.x_id == @current_user.id
      if @tictactoe.turn == "x"
        if @tictactoe.b2 == nil
    @tictactoe.b2 = "x"
    @tictactoe.turn = "o"
    @tictactoe.save!
      else
    flash[:tictactoe] = "not valid move"
      end
    else
      flash[:tictactoe] = "not your turn"
    end
  elsif @tictactoe.o_id == @current_user.id
          if @tictactoe.turn == "o"
          if @tictactoe.b2 == nil
    @tictactoe.b2 = "o"
    @tictactoe.turn = "x"
    @tictactoe.save!
  else
flash[:tictactoe] = "not valid move"
  end
    else
    flash[:tictactoe] = "not your turn"
    end
    end
    end
    redirect_to tictacto_path(@tictactoe)
  end

  def b3
    if logged_in?
    if @tictactoe.x_id == @current_user.id
      if @tictactoe.turn == "x"
        if @tictactoe.b3 == nil
    @tictactoe.b3 = "x"
    @tictactoe.turn = "o"
    @tictactoe.save!
      else
    flash[:tictactoe] = "not valid move"
      end
    else
      flash[:tictactoe] = "not your turn"
    end
  elsif @tictactoe.o_id == @current_user.id
          if @tictactoe.turn == "o"
          if @tictactoe.b3 == nil
    @tictactoe.b3 = "o"
    @tictactoe.turn = "x"
    @tictactoe.save!
  else
flash[:tictactoe] = "not valid move"
  end
    else
    flash[:tictactoe] = "not your turn"
    end
    end
    end
    redirect_to tictacto_path(@tictactoe)
  end

  def c1
    if logged_in?
    if @tictactoe.x_id == @current_user.id
      if @tictactoe.turn == "x"
        if @tictactoe.c1 == nil
    @tictactoe.c1 = "x"
    @tictactoe.turn = "o"
    @tictactoe.save!
      else
    flash[:tictactoe] = "not valid move"
      end
    else
      flash[:tictactoe] = "not your turn"
    end
  elsif @tictactoe.o_id == @current_user.id
          if @tictactoe.turn == "o"
          if @tictactoe.c1 == nil
    @tictactoe.c1 = "o"
    @tictactoe.turn = "x"
    @tictactoe.save!
  else
flash[:tictactoe] = "not valid move"
  end
    else
    flash[:tictactoe] = "not your turn"
    end
    end
    end
    redirect_to tictacto_path(@tictactoe)
  end

  def c2
    if logged_in?
    if @tictactoe.x_id == @current_user.id
      if @tictactoe.turn == "x"
        if @tictactoe.c2 == nil
    @tictactoe.c2 = "x"
    @tictactoe.turn = "o"
    @tictactoe.save!
      else
    flash[:tictactoe] = "not valid move"
      end
    else
      flash[:tictactoe] = "not your turn"
    end
  elsif @tictactoe.o_id == @current_user.id
          if @tictactoe.turn == "o"
          if @tictactoe.c2 == nil
    @tictactoe.c2 = "o"
    @tictactoe.turn = "x"
    @tictactoe.save!
  else
flash[:tictactoe] = "not valid move"
  end
    else
    flash[:tictactoe] = "not your turn"
    end
    end
    end
    redirect_to tictacto_path(@tictactoe)
  end

  def c3
    if logged_in?
    if @tictactoe.x_id == @current_user.id
      if @tictactoe.turn == "x"
        if @tictactoe.c3 == nil
    @tictactoe.c3 = "x"
    @tictactoe.turn = "o"
    @tictactoe.save!
      else
    flash[:tictactoe] = "not valid move"
      end
    else
      flash[:tictactoe] = "not your turn"
    end
  elsif @tictactoe.o_id == @current_user.id
          if @tictactoe.turn == "o"
          if @tictactoe.c3 == nil
    @tictactoe.c3 = "o"
    @tictactoe.turn = "x"
    @tictactoe.save!
  else
flash[:tictactoe] = "not valid move"
  end
    else
    flash[:tictactoe] = "not your turn"
    end
    end
    end
    redirect_to tictacto_path(@tictactoe)
  end

  private

  def tictactoe_params

    params.require(:tictactoe).permit(:x_id, :o_id)

  end

  def find_tictactoe
    @tictactoe = Tictactoe.find(params[:id])
 end
end
