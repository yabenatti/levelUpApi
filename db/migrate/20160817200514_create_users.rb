class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :name
    	t.string :email, null: false
      t.string :password_digest
    	t.string :pet_name
    	t.datetime :birth_date

      t.timestamps
    end
  end
end
