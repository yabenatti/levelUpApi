class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.string :description
    	t.references :user
    	t.references :post

      t.timestamps
    end
  end
end
