class ProfilesController < ApplicationController
  before_action :find_profile, only: %i[show edit update]

  def new
    @profile = Profile.new
      end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
      msg = @profile.errors.full_messages
flash.now[:error] = msg
    end
  end

  def edit; end

  def update
    if @profile.update(profile_params)
      p 'profile successfully updated'
      redirect_back(fallback_location: root_path)
    else
      msg = @profile.errors.full_messages
flash.now[:error] = msg
      redirect_back(fallback_location: root_path)
    end
end

  def show
    @profile = Profile.find(params[:id])

  end

  def index
    @profiles = Profile.all
  end

  def destroy
  @profile = Profile.find(params[:profile_id])
  @profile.destroy
  redirect_to register_path
end


  private

  def profile_params

    params.require(:profile).permit(:color, :username, :desc, :online_at)

  end

  def find_profile
    @profile = Profile.find(params[:id])
 end
end
