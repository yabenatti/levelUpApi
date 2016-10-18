class CreateBeacons < ActiveRecord::Migration
  def change
    create_table :beacons do |t|
    	t.string :unique_id, null: false
    	t.string :minor
    	t.string :major
    	t.string :pet_image
    	t.belongs_to :user


      t.timestamps null: false
    end
  end
end
