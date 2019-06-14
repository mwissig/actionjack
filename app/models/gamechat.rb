class Gamechat < ApplicationRecord
  belongs_to :user
  validates :body, presence: true
    scope :for_display, -> { order(:created_at).last(200) }
    before_save :default_values
    def default_values
      self.game_id ||= @game_id
      self.game_type ||= @gametype
    end

end
