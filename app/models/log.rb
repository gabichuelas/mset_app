class Log < ApplicationRecord
  validates :user_id, :symptom_id, :time, presence: true

  belongs_to :user
  belongs_to :symptom
end
