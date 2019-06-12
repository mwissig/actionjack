class TictactoeController < ApplicationController
    before_action :find_tictactoe, only: %i[show edit update]
  def new
  end

  def edit
  end

  def index
  end

  def show
    @winner ||= ""

if @tictactoe.a1 == @tictactoe.b1 == @tictactoe.c1
	@winner == @tictactoe.a1
end
if @tictactoe.a2 == @tictactoe.b2 == @tictactoe.c2
	@winner == @tictactoe.a2
end
if @tictactoe.a3 == @tictactoe.b3 == @tictactoe.c3
	@winner == @tictactoe.a3
end
if @tictactoe.a1 == @tictactoe.a2 == @tictactoe.a3
	@winner == @tictactoe.a1
end
if @tictactoe.b1 == @tictactoe.b2 == @tictactoe.b3
	@winner == @tictactoe.b1
end
if @tictactoe.c1 == @tictactoe.c2 == @tictactoe.c3
	@winner == @tictactoe.c1
end
if @tictactoe.a1 == @tictactoe.b2 == @tictactoe.c3
	@winner == @tictactoe.a1
end
if @tictactoe.a3 == @tictactoe.b2 == @tictactoe.c1
	@winner == @tictactoe.a3
end
if @tictactoe.a1 != nil && @tictactoe.a2 != nil && @tictactoe.a3 != nil && @tictactoe.b1 != nil && @tictactoe.b2 != nil && @tictactoe.b3 != nil && @tictactoe.c1 != nil && @tictactoe.c2 != nil && @tictactoe.c3 != nil && @winner == ""
  @winner = "none"
end
p @winner
  end

  def a1
  end

  def a2
  end

  def a3
  end

  def b1
  end

  def b2
  end

  def b3
  end

  def c1
  end

  def c2
  end

  def c3
  end

  private

  def user_params

    params.require(:tictactoe).permit(:email, :password, :password_confirmation, :time_zone, :admin, :banned_from_chat, :ban_until, :points, :wins, :losses, :time_since_daily_bonus)

  end

  def find_tictactoe
    @tictactoe = Tictactoe.find(params[:id])
 end
end
