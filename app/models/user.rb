class User < ApplicationRecord
  validates :uid, :email, :access_token, presence: true

  has_many :logs
  has_many :symptoms, through: :logs

  def self.from_omniauth(user_info)
    user_attributes = {
      uid:           user_info[:uid],
      email:         user_info[:info][:email],
      first_name:    user_info[:info][:first_name],
      last_name:     user_info[:info][:last_name],
      access_token:  user_info[:credentials][:token],
    }
    user = User.create(user_attributes)
    user
  end
end
