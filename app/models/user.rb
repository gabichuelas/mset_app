class User < ApplicationRecord
  validates :uid, :email, :access_token, presence: true

  has_many :user_medications
  has_many :medications, through: :user_medications
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

  def full_name
    first_name + " " + last_name
  end

  def potential_symptoms
    Symptom.joins(:medications).pluck(:description).uniq
  end

  def has_medication?(med_id)
    return true if self.user_medications.find_by(medication_id: med_id)
    false
  end

  def add_medication(med_id)
    UserMedication.create(user_id: self.id, medication_id: med_id) unless self.has_medication?(med_id)

  def most_recent_logs
    logs.order(when: :desc).limit(10)
  end
end
