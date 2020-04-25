class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many:activites, dependent: :destroy
  has_many:orders
  has_many:groups, dependent: :destroy
  has_many:orderdetails, dependent: :destroy
  has_many :friendships
  has_many :friends, through: :friendships
  has_one_attached :register_image


  #my order info hazem
  has_many:notifications
  has_many:orders, through: :notifications

  devise :omniauthable, :omniauth_providers => [:facebook,:google]
  # devise :rememberable, :omniauthable, omniauth_providers: []

  # verify your schema for the additional fields/columns
  def self.new_with_session(params, session)
    super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank? end
      end
    end
    def self.from_omniauth(auth)
      print "*********************"
      print auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name 
      user.image = auth.info.image 
    end
  end
end
