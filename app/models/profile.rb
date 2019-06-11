class Profile < ApplicationRecord
    belongs_to :user
    validates :username, presence: true, uniqueness: { case_sensitive: false },
                       length: { maximum: 15 }
    validates :color, presence: true, length: { is: 6 }
end
