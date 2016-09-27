class CreatePosts < ActiveRecord::Migration
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
