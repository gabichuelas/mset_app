class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.references :user, foreign_key: true
      t.references :symptom, foreign_key: true
      t.string :time
      t.string :note

      t.timestamps
    end
  end
end
