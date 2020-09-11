class CreateUserMedications < ActiveRecord::Migration[5.2]
  def change
    create_table :user_medications do |t|
      t.references :user, foreign_key: true
      t.references :medication, foreign_key: true

      t.timestamps
    end
  end
end
