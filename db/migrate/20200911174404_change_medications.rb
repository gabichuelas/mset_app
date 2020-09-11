class ChangeMedications < ActiveRecord::Migration[5.2]
  def change
    rename_column :medications, :med_id, :product_ndc
  end
end
