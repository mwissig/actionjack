class Profile < ApplicationRecord
    belongs_to :user
    validates :username, presence: true, length: { maximum: 20 }
    validates :color, presence: true, length: { is: 6 }
end
