class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
    	t.string :name
    	t.string :email, null: false
      t.string :password_digest
    	t.string :pet_name
    	t.references :beacon
    	t.datetime :birth_date

      t.timestamps
    end
  end
end
