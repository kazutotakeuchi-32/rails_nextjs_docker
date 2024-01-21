class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name , null: false
      t.string :email , null: false, unique: true
      
      # パスワード(暗号化)
      t.string :password_digest , null: false
      
      # 本人確認 
      t.string :activation_digest
      t.datetime :activated_at
      t.datetime :activated_expired_at

      
      # パスワード再設定
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.datetime :reset_expired_at
      t.boolean :allow_password_change, default: false

      t.integer :status, null: false, default: 0, limit: 1
      t.timestamps

    end
    add_index :users, :email, unique: true
    add_index :users, :name, unique: false
  end
end
