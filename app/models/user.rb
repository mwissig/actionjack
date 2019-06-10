require 'bcrypt'
class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token, :reset_token
  before_save :default_values
  before_save { self.email = email.downcase }
  def default_values
    self.time_zone ||= "Eastern Time (US & Canada)"
    self.username ||= "Player" + self.id.to_s
  end
  has_secure_password
  validates :time_zone, presence: true, length: { minimum: 3 }
  validates :password, presence: true, length: { maximum: 32, minimum: 6 }
  validates :email, presence: true, length: { maximum: 100 }
  validates :password, confirmation: { case_sensitive: true }
  before_commit :set_confirmation_token, only: %i[new create]
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  # BCRYPT::Engine.min_cost
    BCrypt::Password.create(string, cost: cost)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def create
   @user = User.new(user_params)
   if @user.save
      @user.set_confirmation_token
      @user.save(validate: false)
                  UserMailer.registration_confirmation(@user).deliver_now
     flash[:success] = "Please confirm your email address to continue"
  else
     flash[:error] = "Invalid, please try again"
     render :new
  end
end

# Sets the password reset attributes.
def create_reset_digest
  self.reset_token = User.new_token
  update_attribute(:reset_digest,  User.digest(reset_token))
  update_attribute(:reset_sent_at, Time.zone.now)
end

# Sends password reset email.
def send_password_reset_email
  UserMailer.password_reset(self).deliver_now
end

  # private

def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  def set_confirmation_token
     if self.confirm_token.blank?
         self.confirm_token = SecureRandom.urlsafe_base64.to_s
   end
 end

 def User.new_token
   SecureRandom.urlsafe_base64.to_s
 end


end
