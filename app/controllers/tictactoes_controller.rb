class TictactoesController < ApplicationController

    before_action :find_tictactoe, only: %i[show edit update a1 a2 a3 b1 b2 b3 c1 c2 c3]
    before_action :define_players, only: %i[show edit update a1 a2 a3 b1 b2 b3 c1 c2 c3]
    before_action :win_conditions, only: %i[show edit update a1 a2 a3 b1 b2 b3 c1 c2 c3]

    def new
      @tictactoe = Tictactoe.new
      if logged_in?
        @random_opponent = @thisweekusers.where.not(id: @current_user.id).sample
      end
    end

    def create
      if logged_in?
      @tictactoe = Tictactoe.new(tictactoe_params)
      if @tictactoe.save
        @notification = Notification.create(
          user_id: @tictactoe.o_id,
          sender_id: @tictactoe.x_id,
          body: 'A new tic-tac-toe game has been created.',
          game: 'tictactoe',
          game_id: @tictactoe.id,
          points: 0
        )
      end
      @to_user = User.find_by(id: @notification.user_id)
      @notecount = @to_user.notifications.where(read: false).count
          ActionCable.server.broadcast 'notifications_channel',
                          notecount: @notecount
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
# A method that writes the 9 mehtods: doesn't work
#
    # @defgrid = ['a1', 'a2', 'a3', 'b1', 'b2', 'b3', 'c1', 'c2', 'c3']
    # @defgrid.each do |coords|
    #   define_method(coords) do
    #     if logged_in?
    #       if @tictactoe.turn == @current_user_mark
    #         if @tictactoe.coords == nil
    #           @tictactoe.coords = @current_user_mark
    #             if @tictactoe.turn == "x"
    #               @tictactoe.turn = "o"
    #             elsif @tictactoe.turn == "o"
    #               @tictactoe.turn = "o"
    #           end
    #           @tictactoe.save!
    #           if @tictactoe.save
    #               ActionCable.server.broadcast 'tictactoe_channel',
    #                               coords: @tictactoe.coords
    #           end
    #         else
    #           flash[:tictactoe] = "Invalid move."
    #         end
    #       else
    #         flash[:tictactoe] = "It's the other player's turn."
    #       end
    #     end
    #   end
    #   end
    # end

    def a1
      if logged_in?
        if @tictactoe.turn == @current_user_mark && @tictactoe.a1 == nil
          @tictactoe.a1 = @current_user_mark
          if @tictactoe.turn == "x"
            @tictactoe.turn = "o"
          elsif @tictactoe.turn == "o"
            @tictactoe.turn = "x"
          end
          @tictactoe.save!
          if @tictactoe.save
          ActionCable.server.broadcast 'tictactoe_channel',
                            a1: @tictactoe.a1,
                            ticmessage: nil,
                            ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                            id: @tictactoe.id
        end
        if @tictactoe.a1 != nil && @tictactoe.a1 != @current_user_mark
        ActionCable.server.broadcast 'tictactoe_channel',
                          ticmessage: "Invalid move.",
                          ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                          id: @tictactoe.id
      end
        end
      end
        redirect_to tictacto_path(@tictactoe)
    end

    def a2
      if logged_in?
        if @tictactoe.turn == @current_user_mark && @tictactoe.a2 == nil
          @tictactoe.a2 = @current_user_mark
          if @tictactoe.turn == "x"
            @tictactoe.turn = "o"
          elsif @tictactoe.turn == "o"
            @tictactoe.turn = "x"
          end
          @tictactoe.save!
          if @tictactoe.save
          ActionCable.server.broadcast 'tictactoe_channel',
                            a2: @tictactoe.a2,
                            ticmessage: nil,
                            ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                            id: @tictactoe.id
        end
        if @tictactoe.a2 != nil && @tictactoe.a2 != @current_user_mark
        ActionCable.server.broadcast 'tictactoe_channel',
                          ticmessage: "Invalid move.",
                          ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                          id: @tictactoe.id
      end
        end
      end
        redirect_to tictacto_path(@tictactoe)
    end

    def a3
      if logged_in?
        if @tictactoe.turn == @current_user_mark && @tictactoe.a3 == nil
          @tictactoe.a3 = @current_user_mark
          if @tictactoe.turn == "x"
            @tictactoe.turn = "o"
          elsif @tictactoe.turn == "o"
            @tictactoe.turn = "x"
          end
          @tictactoe.save!
          if @tictactoe.save
          ActionCable.server.broadcast 'tictactoe_channel',
                            a3: @tictactoe.a3,
                            ticmessage: nil,
                            ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                            id: @tictactoe.id
        end
        if @tictactoe.a3 != nil && @tictactoe.a3 != @current_user_mark
        ActionCable.server.broadcast 'tictactoe_channel',
                          ticmessage: "Invalid move.",
                          ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                          id: @tictactoe.id
      end
        end
      end
        redirect_to tictacto_path(@tictactoe)
    end

    def b1
      if logged_in?
        if @tictactoe.turn == @current_user_mark && @tictactoe.b1 == nil
          @tictactoe.b1 = @current_user_mark
          if @tictactoe.turn == "x"
            @tictactoe.turn = "o"
          elsif @tictactoe.turn == "o"
            @tictactoe.turn = "x"
          end
          @tictactoe.save!
          if @tictactoe.save
          ActionCable.server.broadcast 'tictactoe_channel',
                            b1: @tictactoe.b1,
                            ticmessage: nil,
                            ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                            id: @tictactoe.id
        end
        if @tictactoe.b1 != nil && @tictactoe.b1 != @current_user_mark
        ActionCable.server.broadcast 'tictactoe_channel',
                          ticmessage: "Invalid move.",
                          ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                          id: @tictactoe.id
      end
        end
      end
        redirect_to tictacto_path(@tictactoe)
    end

    def b2
      if logged_in?
        if @tictactoe.turn == @current_user_mark && @tictactoe.b2 == nil
          @tictactoe.b2 = @current_user_mark
          if @tictactoe.turn == "x"
            @tictactoe.turn = "o"
          elsif @tictactoe.turn == "o"
            @tictactoe.turn = "x"
          end
          @tictactoe.save!
          if @tictactoe.save
          ActionCable.server.broadcast 'tictactoe_channel',
                            b2: @tictactoe.b2,
                            ticmessage: nil,
                            ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                            id: @tictactoe.id
        end
        if @tictactoe.b2 != nil && @tictactoe.b2 != @current_user_mark
        ActionCable.server.broadcast 'tictactoe_channel',
                          ticmessage: "Invalid move.",
                          ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                          id: @tictactoe.id
      end
        end
      end
        redirect_to tictacto_path(@tictactoe)
    end

    def b3
      if logged_in?
        if @tictactoe.turn == @current_user_mark && @tictactoe.b3 == nil
          @tictactoe.b3 = @current_user_mark
          if @tictactoe.turn == "x"
            @tictactoe.turn = "o"
          elsif @tictactoe.turn == "o"
            @tictactoe.turn = "x"
          end
          @tictactoe.save!
          if @tictactoe.save
          ActionCable.server.broadcast 'tictactoe_channel',
                            b3: @tictactoe.b3,
                            ticmessage: nil,
                            ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                            id: @tictactoe.id
        end
        if @tictactoe.b3 != nil && @tictactoe.b3 != @current_user_mark
        ActionCable.server.broadcast 'tictactoe_channel',
                          ticmessage: "Invalid move.",
                          ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                          id: @tictactoe.id
      end
        end
      end
        redirect_to tictacto_path(@tictactoe)
    end

    def c1
      if logged_in?
        if @tictactoe.turn == @current_user_mark && @tictactoe.c1 == nil
          @tictactoe.c1 = @current_user_mark
          if @tictactoe.turn == "x"
            @tictactoe.turn = "o"
          elsif @tictactoe.turn == "o"
            @tictactoe.turn = "x"
          end
          @tictactoe.save!
          if @tictactoe.save
          ActionCable.server.broadcast 'tictactoe_channel',
                            c1: @tictactoe.c1,
                            ticmessage: nil,
                            ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                            id: @tictactoe.id
        end
        if @tictactoe.c1 != nil && @tictactoe.c1 != @current_user_mark
        ActionCable.server.broadcast 'tictactoe_channel',
                          ticmessage: "Invalid move.",
                          ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                          id: @tictactoe.id
      end
        end
      end
        redirect_to tictacto_path(@tictactoe)
    end

    def c2
      if logged_in?
        if @tictactoe.turn == @current_user_mark && @tictactoe.c2 == nil
          @tictactoe.c2 = @current_user_mark
          if @tictactoe.turn == "x"
            @tictactoe.turn = "o"
          elsif @tictactoe.turn == "o"
            @tictactoe.turn = "x"
          end
          @tictactoe.save!
          if @tictactoe.save
          ActionCable.server.broadcast 'tictactoe_channel',
                            c2: @tictactoe.c2,
                            ticmessage: nil,
                            ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                            id: @tictactoe.id
        end
        if @tictactoe.c2 != nil && @tictactoe.c2 != @current_user_mark
        ActionCable.server.broadcast 'tictactoe_channel',
                          ticmessage: "Invalid move.",
                          ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                          id: @tictactoe.id
      end
        end
      end
        redirect_to tictacto_path(@tictactoe)
    end

def c3
  if logged_in?
    if @tictactoe.turn == @current_user_mark && @tictactoe.c3 == nil
      @tictactoe.c3 = @current_user_mark
      if @tictactoe.turn == "x"
        @tictactoe.turn = "o"
      elsif @tictactoe.turn == "o"
        @tictactoe.turn = "x"
      end
      @tictactoe.save!
      if @tictactoe.save
      ActionCable.server.broadcast 'tictactoe_channel',
                        c3: @tictactoe.c3,
                        ticmessage: nil,
                        ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                        id: @tictactoe.id
    end
    if @tictactoe.c3 != nil && @tictactoe.c3 != @current_user_mark
    ActionCable.server.broadcast 'tictactoe_channel',
                      ticmessage: "Invalid move.",
                      ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                      id: @tictactoe.id
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

 def define_players
   @user_x = User.find_by(id: @tictactoe.x_id)
   @user_o = User.find_by(id: @tictactoe.o_id)
   if logged_in?
     if @current_user == @user_x
       @current_user_mark = "x"
     elsif @current_user == @user_o
       @current_user_mark = "o"
     end
   end
 end

 def win_conditions
     if @tictactoe.a1 == @tictactoe.a2 && @tictactoe.a1 == @tictactoe.a3
       @winner = @tictactoe.a1
     elsif @tictactoe.a1 == @tictactoe.b1 && @tictactoe.a1 == @tictactoe.c1
       @winner = @tictactoe.a1
     elsif @tictactoe.a1 == @tictactoe.b2 && @tictactoe.a1 == @tictactoe.c3
       @winner = @tictactoe.a1
     elsif @tictactoe.a2 == @tictactoe.b2 && @tictactoe.a2 == @tictactoe.c2
       @winner = @tictactoe.a2
     elsif @tictactoe.a3 == @tictactoe.b3 && @tictactoe.a3 == @tictactoe.c3
       @winner = @tictactoe.a3
     elsif @tictactoe.a3 == @tictactoe.b2 && @tictactoe.a3 == @tictactoe.c1
       @winner = @tictactoe.a3
     elsif @tictactoe.b1 == @tictactoe.b2 && @tictactoe.b1 == @tictactoe.b3
       @winner = @tictactoe.b1
     elsif @tictactoe.c1 == @tictactoe.c2 && @tictactoe.c1 == @tictactoe.c3
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
                                 ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                                 ticmessage: "<span class='winner'>It's a draw.</span>",
                                 ticreload: "<button class='refresh' value='Play Again' onClick='window.location.reload();'>Play Again</button>"
                             end
                   @winner = nil
     end

     if @winner == "x"
     flash[:tictactoe] = @user_x.profile.username + " wins"
             @tictactoe.increment!(:x_wins, 1)
             @user_x.increment!(:points, 10)
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
                   x_wincount: @tictactoe.x_wins,
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
                   ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                   ticmessage: "<span class='winner'>" + @user_x.profile.username + " won.</span>",
                   ticreload: "<button class='refresh' value='Play Again' onClick='window.location.reload();'>Play Again</button>"
               end
               @winner = nil
           end

           if @winner == "o"
                     flash[:tictactoe] = @user_o.profile.username + " wins"
             @tictactoe.increment!(:o_wins, 1)
             @user_o.increment!(:points, 10)
             @tictactoe.turn = "o"
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
                   o_wincount: @tictactoe.o_wins,
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
                   ticturn: "It's " + @tictactoe.turn.upcase + "'s turn.",
                   ticmessage: "<span class='winner'>" + @user_o.profile.username + " won.</span>",
                   ticreload: "<button class='refresh' value='Play Again' onClick='window.location.reload();'>Play Again</button>"
               end
               @winner = nil
           end


   end



end
