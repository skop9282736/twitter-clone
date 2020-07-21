class Like < ApplicationRecord
  has_many :users
  has_many :tweets

  # validates_uniqueness_of :users, scope: :tweets
end
