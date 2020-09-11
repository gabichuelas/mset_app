class ChangeLogs < ActiveRecord::Migration[5.2]
  def change
    change_column :logs, :time, :datetime
    change_column :logs, :note, :text
  end
end
