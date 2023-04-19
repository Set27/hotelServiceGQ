class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.integer :price
      t.integer :capacity
      t.references :room, null: true, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
