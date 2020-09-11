class Log < ApplicationRecord
  validates :user_id, :symptom_id, presence: true

  belongs_to :user
  belongs_to :symptom
end
