
class PagesController < ApplicationController
  def home
    @lobbychats = Lobbychat.all.last(200)
    @recent_tictactoes = Tictactoe.all.order(updated_at: :desc).last(8)
    @grid = ['a1', 'a2', 'a3', 'b1', 'b2', 'b3', 'c1', 'c2', 'c3']
    if logged_in?
          @lobbychat = @current_user.lobbychats.new
    end
  end

def slots
  @lobbychats = Lobbychat.all.last(200)
  if logged_in?
        @lobbychat = @current_user.lobbychats.new
      end
end

  def slots2
    if logged_in?
      if @current_user.points >= 10
        @current_user.decrement!(:points, 10)
        @reel = ["<i class='fas fa-pepper-hot red'></i>", "<span class='bar'>BAR</span>", "<b>7</b>", "JACKPOT", "<i class='fas fa-anchor'></i>", "<i class='fas fa-lemon yellow'></i>", "<i class='fas fa-money-bill-wave green'></i>", "<i class='fas fa-coins gold''></i>", "<i class='fas fa-star purple'></i>"]
        @reel1 = @reel.sample
        @reel2 = @reel.sample
        @reel3 = @reel.sample
        @message = ""
        @amount = 0
        if @reel1 == "JACKPOT" && @reel1 == @reel2 && @reel2 == @reel3
          @message = "JACKPOT! You won"
          @amount = 1000
          @current_user.increment!(:points, 1000)
         elsif @reel1 == @reel2 && @reel2 == @reel3
          @message = "You won"
          @amount = 100
          @current_user.increment!(:points, 100)
        elsif @reel1 == @reel3 && @reel1 != @reel2
          @message = "You won"
          @amount = 50
          @current_user.increment!(:points, 50)
        else
          @message = "You lost"
          @amount = 0
        end
        if @amount > 0
        flash[:slots] = "<h3>" + @reel1 + " " + @reel2 + " " + @reel3 + "</h3> " + @message + " " + @amount.to_s + "</p>"
      else
        flash[:slots] = "<h3>" + @reel1 + " " + @reel2 + " " + @reel3 + "</h3><p> " + @message + "</p>"
      end
        redirect_to games_slots_path
      else
      flash[:slots] = "You do not have enough points."
    end
  end
end

  def shop
  end
end
