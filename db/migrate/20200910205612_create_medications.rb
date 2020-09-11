class CreateMedications < ActiveRecord::Migration[5.2]
  def change
    create_table :medications do |t|
      t.string :brand_name
      t.string :generic_name
      t.string :med_id

      t.timestamps
    end
  end
end
