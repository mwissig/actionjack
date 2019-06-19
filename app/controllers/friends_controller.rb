class FriendsController < ApplicationController
    before_action :find_friend, only: %i[show edit update]

    def new
      @friend = Friend.new
      end

    def create
      @friend = Friend.new(friend_params)
      @friend.save!
        if @friend.save
          if @friend.accepted == false
              @notification = Notification.create(
                user_id: @friend.recipient_id,
                sender_id: @friend.user_id,
                body: 'User has sent a friendship request.',
                game: 'friend_sent',
                game_id: @friend.id,
                points: 0
              )
            elsif @friend.accepted == true
              @original_request = Friend.where('user_id = ? AND recipient_id = ?', @friend.recipient_id, @friend.user_id).first
              @original_request.accepted = true
              @original_request.save!
              @notification = Notification.create(
                user_id: @friend.recipient_id,
                sender_id: @friend.user_id,
                body: 'User has accepted a friendship request.',
                game: 'friend_accepted',
                game_id: @friend.id,
                points: 0
              )
          end
        @to_user = User.find_by(id: @notification.user_id)
        @notecount = @to_user.notifications.where(read: false).count
        ActionCable.server.broadcast 'notifications_channel',
                        notecount: @notecount
          redirect_to user_path(@friend.recipient_id)
      else
        redirect_to user_path(@friend.recipient_id)
        msg = @friend.errors.full_messages
        flash.now[:error] = msg
      end
    end

    def edit; end

    def update
      if @friend.update(friend_params)
        p 'friend successfully updated'
        redirect_back(fallback_location: root_path)
      else
        msg = @friend.errors.full_messages
        flash.now[:error] = msg
        redirect_back(fallback_location: root_path)
      end
  end

    def show
      @friend = Friend.find(params[:id])
      @friend = @current_friend.friend.new(friend_params)
    end

    def index
      @friends = Friend.all
    end

    def destroy
    @friend = Friend.find(params[:friend_id])
    @friend.destroy
    redirect_to root_path
  end


    private

    def friend_params

      params.require(:friend).permit(:user_id, :recipient_id, :accepted)

    end

    def find_friend
      @friend = Friend.find(params[:id])
   end
  end
