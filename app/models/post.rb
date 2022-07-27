# frozen_string_literal: true

class Post < ApplicationRecord
  acts_as_votable

  belongs_to :user
  has_many :comments, dependent: :destroy

  has_one_attached :image

  validates :user_id, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 300 }

  validate :image_presence

  scope :of_followed_users, ->(following_users) { where user_id: following_users }
  scope :of_current_user, ->(current_user) { where user_id: current_user }

  def image_presence
    errors.add(:image, 'Не может быть пустым!') unless image.attached?
  end

  def formatted_created_at
    created_at.strftime('%d %b, %H:%M')
  end
end
