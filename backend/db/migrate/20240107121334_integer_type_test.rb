class IntegerTypeTest < ActiveRecord::Migration[7.0]
  create_table :integer_type_tests do |t|
    t.integer :integer1, null: false, default: 0, limit: 1
    t.integer :integer2, null: false, default: 0, limit: 2
    t.integer :integer3, null: false, default: 0, limit: 3
    t.integer :integer4, null: false, default: 0, limit: 4
    t.integer :integer5, null: false, default: 0, limit: 5
    t.integer :integer6, null: false, default: 0, limit: 6
    t.integer :integer7, null: false, default: 0, limit: 7
    t.integer :integer8, null: false, default: 0, limit: 8
  end
end
