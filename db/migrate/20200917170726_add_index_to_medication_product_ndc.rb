class AddIndexToMedicationProductNdc < ActiveRecord::Migration[5.2]
  def change
    add_index :medications, :product_ndc, unique: true
  end
end
