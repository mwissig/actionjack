class PagesController < ApplicationController
  def home
    @lobbychats = Lobbychat.all.last(200)
    if logged_in?
          @lobbychat = @current_user.lobbychats.new
        end
  end
end
