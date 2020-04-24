class Group < ApplicationRecord
  belongs_to :user
  has_many :friendships, dependent: :destroy
end
