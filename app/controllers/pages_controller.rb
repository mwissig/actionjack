
class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def home
    @lobbychats = Lobbychat.all.last(200)
    @recent_tictactoes = Tictactoe.all.order(updated_at: :desc).first(8)
    @grid = ['a1', 'a2', 'a3', 'b1', 'b2', 'b3', 'c1', 'c2', 'c3']
    @users = User.all.where.not(id: @current_user.id).order(:id)
    @usernames = []
    @users.each do |user|
      @usernames.push user.profile.username
    end
    @userlist = @usernames.zip(@users.ids)
    if logged_in?
          @lobbychat = @current_user.lobbychats.new
          @random_opponent = @thisweekusers.where.not(user_id: @current_user.id).sample.user
    end
    @tictactoe = Tictactoe.new
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
        @reel = ["<h3><i class='fas fa-pepper-hot red'></i></h3>", "<span class='bar'>BAR</span>", "<h3><b>7</b></h3>", "<span class='jackpot'>JACKPOT</span>", "<h3><i class='fas fa-anchor'></i></h3>", "<h3><i class='fas fa-lemon yellow'></i></h3>", "<h3><i class='fas fa-money-bill-wave green'></i></h3>", "<h3><i class='fas fa-coins gold''></i></h3>", "<h3><i class='fas fa-star purple'></i></h3>"]
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
        flash[:slots] = "<p>" + @message + " " + @amount.to_s + "</p>"
        flash[:slotreel1] = @reel1
        flash[:slotreel2] = @reel2
        flash[:slotreel3] = @reel3
      else
        flash[:slots] = "<p> " + @message + "</p>"
        flash[:slotreel1] = @reel1
        flash[:slotreel1] = @reel1
        flash[:slotreel2] = @reel2
        flash[:slotreel3] = @reel3
      end
        redirect_to games_slots_path
      else
      flash[:slots] = "You do not have enough points."
    end
  end
end

def pictionary
    @lobbychats = Lobbychat.all.last(200)
    @pictionaries = Pictionary.all
    @onlineusers = @pictionaries.where('last_online > ?', 10.minutes.ago)
    @recentusers = @pictionaries.where('last_online > ?', 1.hour.ago)
    if logged_in?
      if @current_user.pictionary != nil
        @pictionary = @current_user.pictionary
        @pictionary.last_online = DateTime.now
        @pictionary.save!
        if @pictionary.save
        ActionCable.server.broadcast 'pictionary_players_channel',
                          name: @current_user.profile.username,
                          last_online: @pictionary.last_online.strftime("%-l:%M%P %B %-d, %Y")
      end
      else
        @pictionary = Pictionary.create(
          user_id: @current_user.id,
          last_online: DateTime.now,
          current_score: 0,
          all_time_score: 0,
          turn: false
        )
        if @pictionary.save
        ActionCable.server.broadcast 'pictionary_players_channel',
                          name: @current_user.profile.username,
                          last_online: @pictionary.last_online.strftime("%-l:%M%P %B %-d, %Y")
      end
end
    end
end

def pic2
  ActionCable.server.broadcast 'pictionary_channel',
    fromx: params[:fromx],
    fromy: params[:fromy],
    tox: params[:tox],
    toy: params[:toy],
    color: params[:color],
    size: params[:size]
  head :ok
end

  def shop
  end
end
