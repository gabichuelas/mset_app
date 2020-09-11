class UserMedication < ApplicationRecord
  validates :user_id, :medication_id, presence: true

  belongs_to :user
  belongs_to :medication
end
