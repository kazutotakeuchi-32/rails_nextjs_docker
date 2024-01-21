class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name , null: false
      t.integer :status, null: false, default: 0, limit: 1
      t.text :description
      # 自己結合(親タグ)
      t.references :parent_tag, foreign_key: { to_table: :tags }, null: true
      t.timestamps
    end
  end
end

