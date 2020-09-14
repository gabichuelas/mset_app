class Log < ApplicationRecord
  validates :user_id, :symptom_id, :when, presence: true

  belongs_to :user
  belongs_to :symptom

  def symptom_description
    Symptom.find(symptom_id).description
  end
end
