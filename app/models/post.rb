class User < ApplicationRecord
    has_many :posts, dependent: :destroy
  end

class Post < ApplicationRecord
    belongs_to :user

    has_one_attached :image

    validates :user_id, presence: true
    validates :description, length: { minimum: 5, maximum: 300 }

    validate :image_presence
    
    def image_presence
      errors.add(:image, "can't be blank") unless image.attached?
    end
end