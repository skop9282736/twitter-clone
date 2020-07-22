class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :users, through: :like

  validates :body, presence: true, length: {maximum: 200}
end
