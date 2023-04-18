class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_enum :room_class, %w[STANDART DELUXE SUITE]
    create_table :rooms do |t|
      t.string :title
      t.integer :price
      t.integer :capacity
      t.enum :rating, enum_type: :room_class 
      t.boolean :is_occupied, default: false
      t.timestamps
    end
  end
end
