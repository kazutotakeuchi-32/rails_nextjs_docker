class CreateCommentLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :comment_likes do |t|
      t.references :comment, null: false
      t.references :user, null: false
      t.integer :type, null: false, default: 0, limit: 1
      t.timestamps
    end
  end
end
