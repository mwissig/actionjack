
class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :get_lobbychats
  def home
    @recent_tictactoes = Tictactoe.all.order(updated_at: :desc).first(6)
    if logged_in?
    @my_tictactoes = Tictactoe.where('x_id = ? OR o_id = ?', @current_user.id, @current_user.id).order(updated_at: :desc)
    end
    @grid = ['a1', 'a2', 'a3', 'b1', 'b2', 'b3', 'c1', 'c2', 'c3']


    if logged_in?
          @random_opponent = @thisweekusers.where.not(user_id: @current_user.id).sample.user
          @users = User.all.where.not(id: @current_user.id).order(:id)
          @usernames = []
          @users.each do |user|
            @usernames.push user.profile.username
          end
          @userlist = @usernames.zip(@users.ids)
    end
    @tictactoe = Tictactoe.new
  end

  def games
  end

def slots
        @slot = Slot.first
        @last_winner = User.find_by(id: @slot.last_winner_id)
        @biggest_winner = User.find_by(id: @slot.biggest_winner_id)
  @lobbychats = Lobbychat.all.last(100)
  if logged_in?
        @lobbychat = @current_user.lobbychats.new
      end
end

  def slots2
    if logged_in?
      @slot = Slot.first
      @last_winner = User.find_by(id: @slot.last_winner_id)
      @biggest_winner = User.find_by(id: @slot.biggest_winner_id)
      if @current_user.points >= 10
        @current_user.decrement!(:points, 10)
        @slot.increment!(:jackpot, 10)
        @reel = ["<h3 class='animated slideInUp fast'><i class='fas fa-pepper-hot red'></i></h3>", "<span class='bar animated slideInUp'>BAR</span>", "<h3 class='animated slideInUp faster'><b>7</b></h3>", "<span class='animated slideInUp slow jackpot'>JACKPOT</span>", "<h3 class='animated slideInDown slow'><i class='fas fa-anchor'></i></h3>", "<h3 class='animated slideInDown'><i class='fas fa-lemon yellow'></i></h3>", "<h3 class='animated slideInDown fast'><i class='fas fa-money-bill-wave green'></i></h3>", "<h3 class='animated slideInUp faster'><i class='fas fa-coins gold'></i></h3>", "<h3 class='animated slideInDown'><i class='fas fa-star purple'></i></h3>"]
        @reel1 = @reel.sample
        @reel2 = @reel.sample
        @reel3 = @reel.sample
        @message = ""
        @amount = 0
        if @reel1 == "<span class='animated slideInUp slow jackpot'>JACKPOT</span>" && @reel1 == @reel2 && @reel2 == @reel3
          @message = "JACKPOT! You won<div class='pyro'><div class='before'></div><div class='after'></div></div>"
          @amount = @slot.jackpot
          @time = DateTime.now
          @current_user.increment!(:points, @amount)
          @slot.decrement!(:jackpot, @amount)
          @slot.jackpot = 1000
          @slot.last_win_prize = @amount
          @slot.last_win_date = @time
          @slot.last_winner_id = @current_user.id
          if @amount > @slot.biggest_prize
          @slot.biggest_prize = @amount
          @slot.biggest_winner_id = @current_user.id
          @slot.biggest_win_date = @time
          end
          @slot.save!
         elsif @reel1 == @reel2 && @reel2 == @reel3
          @message = "You won"
          @amount = 100
          @current_user.increment!(:points, 100)
          @slot.decrement!(:jackpot, 10)
        elsif @reel1 == @reel3 && @reel1 != @reel2
          @message = "You won"
          @amount = 50
          @current_user.increment!(:points, 50)
          @slot.decrement!(:jackpot, 50)
        elsif @reel1 == @reel2 && @reel1 != @reel3
          @message = "You won"
          @amount = 5
          @current_user.increment!(:points, 5)
          @slot.decrement!(:jackpot, 5)
        elsif @reel2 == @reel3 && @reel1 != @slotreel2
          @message = "You won"
          @amount = 5
          @current_user.increment!(:points, 5)
          @slot.decrement!(:jackpot, 5)
        else
          @message = "You lost"
          @amount = 0
        end
        if @amount > 0
        flash[:slots] = "<h3 class='animated fadeIn'>" + @message + " " + @amount.to_s + " <i class='fas fa-coins gold'></i></h3>"
        flash[:slotreel1] = @reel1
        flash[:slotreel2] = @reel2
        flash[:slotreel3] = @reel3
      else
        flash[:slots] = "<p class='animated fadeIn'> " + @message + "</p>"
        flash[:slotreel1] = @reel1
        flash[:slotreel1] = @reel1
        flash[:slotreel2] = @reel2
        flash[:slotreel3] = @reel3
      end
        redirect_to games_slots_path
      else
      flash[:slots] = "You do not have enough <i class='fas fa-coins gold'></i>."
    end
  end
end

def pictionary
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
    @items = Shopitem.all
  end

  def buy
    @item_name = params[:name]
    @shopitem = Shopitem.find_by(name: @item_name)
    if @current_user.points >= @shopitem.shop_price.to_i
    @item = Item.create(
      user_id: @current_user.id,
      name: @shopitem.name,
      image: @shopitem.image,
      category: @shopitem.category,
      shop_price: @shopitem.shop_price.to_i,
      sellback_price: @shopitem.sellback_price.to_i,
      user_set_price: 0,
      color: @shopitem.color,
      material: @shopitem.material,
      quality: @shopitem.quality,
      description: @shopitem.description,
      long_description: @shopitem.long_description,
      string1: @shopitem.string1,
      string2: @shopitem.string2,
      integer1: @shopitem.integer1,
      integer2: @shopitem.integer2,
      datetime1: @shopitem.datetime1,
      datetime2: @shopitem.datetime2
    )
    if @item.save
      @current_user.decrement!(:points, @shopitem.shop_price.to_i)
      flash[:shop] = @shopitem.name + " bought."
      redirect_to shop_path
    end
  else
    redirect_to shop_path
    flash[:shop] = "Not enough money"
  end
  end

private

def get_lobbychats
  @lobbychats = Lobbychat.all.last(100)
  if logged_in?
        @lobbychat = @current_user.lobbychats.new
      end
end

end
