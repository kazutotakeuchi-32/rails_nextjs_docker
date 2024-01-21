class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true, unique: true
      t.references :article, null: false, foreign_key: true, unique: true
      t.timestamps
    end
  end
end
