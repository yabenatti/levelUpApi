class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
    	t.string :description
    	t.string :image
    	t.datetime :date
    	t.integer :likes
    	t.belongs_to :user

      t.timestamps
    end
  end
end
