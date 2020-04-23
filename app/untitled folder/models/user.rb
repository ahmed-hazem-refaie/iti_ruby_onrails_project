class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many:activites
  has_many:groups
  has_many:orderdetails
  has_many :friendships, foreign_key: :friend_id, class_name: 'Friendship'
  has_many :friends, through: :friendships
  has_many:orders, through: :notifications
  has_many:notifications
end
