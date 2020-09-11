class User < ApplicationRecord
  validates :uid, :email, :access_token, :refresh_token, presence: true

  has_many :logs
  has_many :symptoms, through: :logs

  def self.from_omniauth(response)
    require "pry"; binding.pry
    user = User.find_or_create_by(uid: response[:uid])
    user.email = response[:info][:email]
    user.access_token = response[:credentials][:token]
    user.refresh_token = response[:credentials][:refresh_token]
    user.save
    user
  end
end
