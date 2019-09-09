class Location < ApplicationRecord
   belongs_to :user
   has_many :location_items
   has_many :items, through: :location_items

   validates :name, presence: true, uniqueness: true

   def item_quantity(item_obj)
      location_item = LocationItem.find_by(location_id: self.id, item_id: item_obj.id)
      location_item.quantity
   end

   def add_or_update_item_quantity(item_obj, quantity)
      location_item = LocationItem.find_by(location_id: self.id, item_id: item_obj.id)   
      location_item.quantity = quantity
      location_item.save
   end

end
