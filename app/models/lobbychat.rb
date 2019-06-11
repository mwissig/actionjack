class Lobbychat < ApplicationRecord
  belongs_to :user
  validates :body, presence: true
    scope :for_display, -> { order(:created_at).last(200) }
end
