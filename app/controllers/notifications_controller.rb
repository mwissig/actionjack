class NotificationsController < ApplicationController
  def new
  end

  def index
    if logged_in?
    @notifications = @current_user.notifications.all.order(created_at: :desc)
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
end
