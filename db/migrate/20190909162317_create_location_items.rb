class CreateLocationItems < ActiveRecord::Migration[5.2]
  def change
    create_table :location_items do |t|
      t.integer :location_id
      t.integer :item_id
      t.integer :quantity, default: 0

      t.timestamps
    end
  end
end
