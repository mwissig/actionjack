class NotificationsController < ApplicationController
  def new
  end

  def index
    if logged_in?
    @notifications = @current_user.notifications.all
  end
  end

  def edit
  end

  def show
  end
end
