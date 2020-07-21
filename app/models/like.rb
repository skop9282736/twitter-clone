class Like < ApplicationRecord
  has_many :user
  has_many :tweet
end
