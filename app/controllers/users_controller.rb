class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update]
before_action :food_for_select, only: %i[show]
  def new
    @user = User.new
      end

  def create
    @user = User.new(user_params)
    if @user.save
      Profile.create(
        username: "Player" + @user.id.to_s,
        color: "000000",
        user_id: @user.id)
      @user.set_confirmation_token
      @user.save(validate: false)
      UserMailer.registration_confirmation(@user).deliver
      flash[:success] = "Please confirm your email address to continue. If you do not recieve a confirmation email, your account will be activated within 24 hours."
      redirect_to login_path(fallback_location: root_path)
    else
      render 'new'
      msg = @user.errors.full_messages
flash.now[:error] = msg
    end
  end

  def edit; end

  def update

    if @user.update(user_params)
      p 'user successfully updated'
      redirect_back(fallback_location: root_path)
    else
      msg = @user.errors.full_messages
flash.now[:error] = msg
      redirect_back(fallback_location: root_path)
    end
end

  def show
    @user = User.find(params[:id])
        @lobbychats = Lobbychat.all.last(100)
        @items = @user.items
    if logged_in?
                @lobbychat = @current_user.lobbychats.new
    @friend = Friend.new
  end
      @friends = @user.friends.where(accepted: true)
  end

  def index
    @users = User.all
  end

  def destroy
  @user = User.find(params[:user_id])
  @user.destroy
  redirect_to register_path
end

def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to the Crepuscular Games! Your email has been confirmed.
      Please sign in to continue."
      redirect_to login_url
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
end

  private

  def user_params

    params.require(:user).permit(:email, :password, :password_confirmation, :time_zone, :admin, :banned_from_chat, :ban_until, :points, :wins, :losses, :time_since_daily_bonus)

  end

  def find_user
    @user = User.find(params[:id])
 end

 def food_for_select
   if logged_in?
   @food = @current_user.items.where(category: "food")
 end
 end

end
