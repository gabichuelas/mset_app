class Log < ApplicationRecord
  validates :user_id, :symptom_id, :when, presence: true

  belongs_to :user
  belongs_to :symptom
end
