class User < ApplicationRecord
    has_many :posts, dependent: :destroy
end

class Post < ApplicationRecord
    belongs_to :user

    has_one_attached :image
end