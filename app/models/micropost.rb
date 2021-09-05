class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc)}
  validates :user_id, presence: true #user_idが空でないことを確かめている
  validates :content, presence: true, length: { maximum: 140 }
end
