class NotificationsController < ApplicationController
  before_action :find_notification, only: %i[show edit update]

  def new
  end

      def create
        if logged_in?
        @notification = Notification.new(notification_params)
        if @notification.save
          @to_user = User.find_by(id: @notification.user_id)
          @from_user = User.find_by(id: @notification.sender_id)
          if @notification.points > 0 && @notification.points <= @from_user.points
            @to_user.increment!(:points, @notification.points)
            @from_user.decrement!(:points, @notification.points)
          end
          @notecount = @to_user.notifications.where(read: false).count
          ActionCable.server.broadcast 'notifications_channel',
                          notecount: @notecount
        redirect_to inbox_path
        if @notification.points > 0
        flash[:inbox] = "You successfully sent a message to " + @to_user.profile.username + " with " + @notification.points.to_s + " <i class='fas fa-coins gold'></i>"
      else
        flash[:inbox] = "You successfully sent a message to " + @to_user.profile.username + "."

      end
        else
          redirect_to inbox_path
          msg = @notification.errors.full_messages
          flash.now[:error] = msg
        end
      end
    end

  def index
    @lobbychats = Lobbychat.all.last(100)
    if logged_in?
      @lobbychat = @current_user.lobbychats.new
      @notification = Notification.create
      @friend = Friend.new
      @friend_user_ids = []
      @friend_usernames = []
      @friends = @current_user.friends.where(accepted: true)
          @friends.each do |friend|
            @user = User.find_by(id: friend.recipient_id)
            @friend_user_ids.push(@user.id)
            @friend_usernames.push(@user.profile.username)
          end
      @friends_for_select = @friend_usernames.zip(@friend_user_ids)
      @notifications = @current_user.notifications.all.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
      @unread_notifications = @notifications.where(read: false)
      @unread_notifications.each do |note|
      note.read = true
      note.save!
    end
  end
  end

  def edit
  end

  def show
  end

  private

  def notification_params
    params.require(:notification).permit(:user_id, :sender_id, :read, :game, :game_id, :body, :points)
  end

  def find_notification
    @notification = Notification.find(params[:id])
 end
end
