class Notification < ApplicationRecord
  belongs_to :user
  before_save :default_values
  def default_values
    self.read ||= false
    self.points ||= 0
  end
end
