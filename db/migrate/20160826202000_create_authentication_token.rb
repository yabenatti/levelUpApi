class CreateAuthenticationToken < ActiveRecord::Migration
  def change
    create_table :authentication_tokens do |t|
      t.references :user, null: false, index: true, foreign_key: true

      t.integer :platform, null: false
      t.string :authentication_token, null: false
      t.datetime :last_used_at

      t.timestamps null: false
    end

    add_index :authentication_tokens, [:user_id, :authentication_token], unique: true
  end
end
