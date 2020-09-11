class ChangeLogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :logs, :time, :string
    add_column :logs, :when, :datetime
    change_column :logs, :note, :text
  end
end
