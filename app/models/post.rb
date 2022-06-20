class Post < ApplicationRecord
    belongs_to :user

    has_one_attached :image

    validates :user_id, presence: true
    validates :description, presence: true, length: { minimum: 5, maximum: 300 }

    validate :image_presence
    
    def image_presence
      errors.add(:image, "can't be blank") unless image.attached?
    end

    def formatted_created_at
      created_at.localtime.strftime('%d %b, %H:%M')
    end
end