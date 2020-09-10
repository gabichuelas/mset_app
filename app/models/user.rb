class User < ApplicationRecord
  validates :uid, :email, :access_token, :refresh_token, presence: true

  has_many :logs
  has_many :symptoms, through: :logs
end
