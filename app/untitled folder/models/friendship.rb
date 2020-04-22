class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend
  belongs_to :group
end
