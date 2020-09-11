class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :email
      t.string :access_token
      t.string :refresh_token
      t.string :first_name
      t.string :last_name
      t.string :birthdate
      t.integer :weight

      t.timestamps
    end
  end
end
