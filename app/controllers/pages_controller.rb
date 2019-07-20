
class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :get_lobbychats
  def home
    @minelinktiles = Minetile.all.order("RANDOM()").limit(140)
    @recent_tictactoes = Tictactoe.all.order(updated_at: :desc).first(6)
    if logged_in?
    @my_tictactoes = Tictactoe.where('x_id = ? OR o_id = ?', @current_user.id, @current_user.id).order(updated_at: :desc)
    end
    @grid = ['a1', 'a2', 'a3', 'b1', 'b2', 'b3', 'c1', 'c2', 'c3']


    if logged_in?
          @random_opponent = @thisweekusers.where.not(user_id: @current_user.id).sample
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

def mine
    @players = Mineplayer.all
    @activeplayers = @players.where('updated_at > ?', 1.hour.ago)
    @tiles = Minetile.all.order("created_at ASC")

    if logged_in?
      @pickaxes = @current_user.items.where(category: "pickaxes").order(integer1: :desc)
      @playerspeed = 200

        if @pickaxes.first != nil
          @pickaxe = @pickaxes.first
          @pickaxename = @pickaxe.name
          @pickaxelevel = @pickaxe.integer1
        else
          @pickaxename = "Bare Hands"
          @pickaxelevel = 0

        end

      if @current_user.mineplayer != nil
        @current_player = @current_user.mineplayer
        @current_player.pickaxe = @pickaxename
        @current_player.axelvl = @pickaxelevel
        @current_player.speed = @playerspeed
        @current_player.controls = "standard"
        @current_player.updated_at = DateTime.now
        @current_player.save!
      else
        @current_player = Mineplayer.create(
          user_id: @current_user.id,
          deltax: 275,
          deltay: 785,
          coords: "15_10",
          pickaxe: @pickaxename,
          axelvl: @pickaxelevel,
          speed: @playerspeed,
          controls: "standard"
        )
      end

      @deltax = @current_player.deltax
      @deltay = @current_player.deltay
      @mycoords = @current_player.coords
    else
      @pickaxename = "Bare Hands"
      @pickaxelevel = 0
      @deltax = 275
      @deltay = 785
      @mycoords = "15_10"
    end

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

  def sell
    @item_name = params[:name]
    @item = @current_user.items.where(name: @item_name).first
      @current_user.increment!(:points, @item.sellback_price.to_i)
      @item.destroy!
    if @item.destroy
      flash[:shop] = @item.name + " sold"
      redirect_to shop_path
    else
    redirect_to shop_path
    flash[:shop] = "Item does not exist"
    end
  end

  def feed
    if logged_in?
      @food_id = params[:food]
      @pet_id = params[:pet]
      @food = Item.find_by(id: @food_id)
      @pet = Item.find_by(id: @pet_id)
      @food_value = @food.integer1
      @pet_current_hunger = @pet.integer1
      @pet_max_hunger = @pet.integer2
      @points_to_max = @pet_max_hunger - @pet_current_hunger
      if @food_value > @points_to_max
        @food_value = @points_to_max + 1
      end
       @pet.increment!(:integer1, @food_value)
       @pet.datetime1 = DateTime.now
       @pet.save!
      @food.destroy!
      redirect_to user_path(@current_user)
    flash[:inventory] = "You have fed your" + @pet.name
  end
  end

  def fillfeeder
    if logged_in?
      @food_id = params[:food]
      @feeder_id = params[:feeder]
      @food = Item.find_by(id: @food_id)
      @feeder = Item.find_by(id: @feeder_id)
      @food_value = @food.integer1
       @feeder.increment!(:integer1, @food_value)
       @feeder.save!
      @food.destroy!
      redirect_to user_path(@current_user)
    flash[:inventory] = "You have added " + @food.integer1.to_s + " food to your Automatic Pet Feeder."
  end
  end


    def dispose
      if logged_in?
        @item_id = params[:item]
        @item = Item.find_by(id: @item_id)
        flash[:inventory] = @item.name + " disposed of."
        @item.destroy!
        redirect_to user_path(@current_user)
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
