class Log < ApplicationRecord
  validates :user_id, :symptom_id, :when, presence: true

  belongs_to :user
  belongs_to :symptom

  def self.order_by_when
    Log.order(when: :desc)
  end
end
