class ApplicationController < ActionController::Base
    protect_from_forgery unless: -> { request.format.json? }
  include SessionsHelper
before_action :set_raven_context
before_action :who_is_on
before_action :i_am_on
private

def set_raven_context
  Raven.user_context(id: session[:current_user_id]) # or anything else in session
  Raven.extra_context(params: params.to_unsafe_h, url: request.url)
end

def who_is_on
  @allrecentusers = Profile.all.where('online_at > ?', 1.hour.ago)
  @thisweekusers = Profile.all.where('online_at > ?', 1.week.ago)
end

def i_am_on
  if logged_in?
    @current_user.profile.online_at = DateTime.now
    @current_user.profile.save!
  end
end

end
