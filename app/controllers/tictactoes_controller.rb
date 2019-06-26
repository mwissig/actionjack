class TictactoesController < ApplicationController

    before_action :find_tictactoe, only: %i[show edit update play]
    before_action :define_players, only: %i[show edit update play]
    before_action :win_conditions, only: %i[show edit update play]

    def new
      @tictactoe = Tictactoe.new
    end

    def create
      if logged_in?
          @tictactoe = Tictactoe.new(tictactoe_params)
          @tictactoe.save!
            if @tictactoe.save
            @notification = Notification.create(
              user_id: @tictactoe.o_id,
              sender_id: @tictactoe.x_id,
              body: 'A new tic-tac-toe game has been created.',
              game: 'tictactoe',
              game_id: @tictactoe.id,
              points: 0
            )
            @to_user = User.find_by(id: @notification.user_id)
            @notecount = @to_user.notifications.where(read: false).count
            ActionCable.server.broadcast 'notifications_channel',
                            notecount: @notecount
              redirect_to tictacto_path(@tictactoe)
            else
              msg = @tictactoe.errors.full_messages
              flash.now[:ticerr] = "msg"
              redirect_back(fallback_location: root_path)
            end
        else
          flash.now[:ticerr] = "No opponent available."
          redirect_back(fallback_location: root_path)
        end
    end

  def edit
  end

  def index
    @tictactoes = Tictactoe.all.order(updated_at: :desc).paginate(page: params[:page], per_page: 12)
    @tictactoe = Tictactoe.new
    @grid = ['a1', 'a2', 'a3', 'b1', 'b2', 'b3', 'c1', 'c2', 'c3']
    @lobbychats = Lobbychat.all.last(100)
    if logged_in?
          @lobbychat = @current_user.lobbychats.new
          @random_opponent = @thisweekusers.where.not(user_id: @current_user.id).sample.user
          @users = User.all.where.not(id: @current_user.id).order(:id)
          @usernames = []
          @users.each do |user|
            @usernames.push user.profile.username
          end
          @userlist = @usernames.zip(@users.ids)
    end
  end

  def show
    @lobbychats = Lobbychat.all.last(100)
    @gametype = "tictactoe"
    @gameid = params[:id]
    @gamechats = Gamechat.where("game_type = ? and game_id = ?", "tictactoe", params[:id]).last(200)
    @grid = ['a1', 'a2', 'a3', 'b1', 'b2', 'b3', 'c1', 'c2', 'c3']
    if !logged_in?
      @current_user_status = "spectator"
    end
    if logged_in?
      @lobbychat = @current_user.lobbychats.new
      if @current_user == @user_x || @current_user == @user_o
        @current_user_status = "player"
          if @current_user == @user_x
            @current_user_mark = "x"
          elsif @current_user == @user_o
            @current_user_mark = "o"
          end
      else
        @current_user_status = "spectator"
      end
    end
  end

def play
  if logged_in?
  @co = params[:co]
    if @tictactoe.turn == @current_user_mark && @tictactoe.send(@co) == nil
        @tictactoe.send("#{@co}=", @current_user_mark)
      if @tictactoe.turn == "x"
        @tictactoe.turn = "o"
      elsif @tictactoe.turn == "o"
        @tictactoe.turn = "x"
      end
      @tictactoe.save!
      if @tictactoe.save
      ActionCable.server.broadcast 'tictactoe_channel',
                        "#{@co}": @tictactoe.send(@co),
                        ticmessage: nil,
                        ticturn: "It's " + @turn_user.profile.username + "'s turn.",
                        id: @tictactoe.id
    end
    if @tictactoe.send(@co) != nil && @tictactoe.send(@co) != @current_user_mark
    ActionCable.server.broadcast 'tictactoe_channel',
                      ticmessage: "Invalid move.",
                      ticturn: "It's " + @turn_user.profile.username + "'s turn.",
                      id: @tictactoe.id
  end
    end
  end
    redirect_to tictacto_path(@tictactoe)
end

  private

  def tictactoe_params
    params.require(:tictactoe).permit(:x_id, :o_id, :id, :co, :button)
  end

  def find_tictactoe
    @tictactoe = Tictactoe.find(params[:id])
 end

 def define_players
   @user_x = User.find_by(id: @tictactoe.x_id)
   @user_o = User.find_by(id: @tictactoe.o_id)
   if @tictactoe.turn == "x"
     @turn_user = @user_x
   elsif @tictactoe.turn == "o"
    @turn_user = @user_o
   end
   if logged_in?
     if @current_user == @user_x
       @current_user_mark = "x"
     elsif @current_user == @user_o
       @current_user_mark = "o"
     end
   end
 end

 def win_conditions
     if @tictactoe.a1 != nil && @tictactoe.a1 == @tictactoe.a2 && @tictactoe.a1 == @tictactoe.a3
       @winner = @tictactoe.a1
     elsif @tictactoe.a1 != nil && @tictactoe.a1 == @tictactoe.b1 && @tictactoe.a1 == @tictactoe.c1
       @winner = @tictactoe.a1
     elsif @tictactoe.a1 != nil && @tictactoe.a1 == @tictactoe.b2 && @tictactoe.a1 == @tictactoe.c3
       @winner = @tictactoe.a1
     elsif @tictactoe.a2 != nil && @tictactoe.a2 == @tictactoe.b2 && @tictactoe.a2 == @tictactoe.c2
       @winner = @tictactoe.a2
     elsif @tictactoe.a3 != nil && @tictactoe.a3 == @tictactoe.b3 && @tictactoe.a3 == @tictactoe.c3
       @winner = @tictactoe.a3
     elsif@tictactoe.a3 != nil && @tictactoe.a3 == @tictactoe.b2 && @tictactoe.a3 == @tictactoe.c1
       @winner = @tictactoe.a3
     elsif @tictactoe.b1 != nil && @tictactoe.b1 == @tictactoe.b2 && @tictactoe.b1 == @tictactoe.b3
       @winner = @tictactoe.b1
     elsif @tictactoe.c1 != nil && @tictactoe.c1 == @tictactoe.c2 && @tictactoe.c1 == @tictactoe.c3
       @winner = @tictactoe.c1
     elsif @tictactoe.a1 != nil && @tictactoe.a2 != nil && @tictactoe.a3 != nil && @tictactoe.b1 != nil && @tictactoe.b2 != nil && @tictactoe.b3 != nil && @tictactoe.c1 != nil && @tictactoe.c2 != nil && @tictactoe.c3 != nil && @winner == nil
       @winner = "none"
     end

     if @winner == "none"
       flash[:tictactoe] = "Tie"
       @tictactoe.a1 = nil
       @tictactoe.a2 = nil
       @tictactoe.a3 = nil
       @tictactoe.b1 = nil
       @tictactoe.b2 = nil
       @tictactoe.b3 = nil
       @tictactoe.c1 = nil
       @tictactoe.c2 = nil
       @tictactoe.c3 = nil
       @tictactoe.turn = ['x', 'o'].sample
       @tictactoe.save!
                 if @tictactoe.save
                     ActionCable.server.broadcast 'tictactoe_channel',
                                 a1: nil,
                                 a2: nil,
                                 a3: nil,
                                 b1: nil,
                                 b2: nil,
                                 b3: nil,
                                 c1: nil,
                                 c2: nil,
                                 c3: nil,
                                 id: @tictactoe.id,
                                 ticturn: "It's " + @turn_user.profile.username + "'s turn.",
                                 ticmessage: "<span class='winner'>It's a draw.</span>",
                                 ticreload: "<button class='refresh' value='Play Again' onClick='window.location.reload();'>Play Again</button>"
                             end
                   @winner = nil
     end

     if @winner == "x" || @winner == "o"
       if @winner == "x"
       @user_winner = @user_x
     elsif @winner == "o"
       @user_winner = @user_o
      end
     flash[:tictactoe] = @user_winner.profile.username + " wins"
             @tictactoe.increment!(:"#{@winner}_wins", 1)
             @user_winner.increment!(:points, 10)
             @tictactoe.turn = "x"
               @tictactoe.a1 = nil
               @tictactoe.a2 = nil
               @tictactoe.a3 = nil
               @tictactoe.b1 = nil
               @tictactoe.b2 = nil
               @tictactoe.b3 = nil
               @tictactoe.c1 = nil
               @tictactoe.c2 = nil
               @tictactoe.c3 = nil
               @tictactoe.save!
               if @tictactoe.save
                   ActionCable.server.broadcast 'tictactoe_channel',
                   "#{@winner}_wincount": @tictactoe.send("#{@winner}_wins"),
                   a1: nil,
                   a2: nil,
                   a3: nil,
                   b1: nil,
                   b2: nil,
                   b3: nil,
                   c1: nil,
                   c2: nil,
                   c3: nil,
                   id: @tictactoe.id,
                   ticturn: "It's " + @turn_user.profile.username + "'s turn.",
                   ticmessage: "<span class='winner'>" + @user_winner.profile.username + " won.</span>",
                   ticreload: "<button class='refresh' value='Play Again' onClick='window.location.reload();'>Play Again</button>"
               end
               @winner = nil
           end

   end



end
