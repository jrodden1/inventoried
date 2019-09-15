class Location < ApplicationRecord
   belongs_to :user
   has_many :location_items
   has_many :items, through: :location_items

   validates :name, presence: true, uniqueness: true

   def item_quantity(item_obj)
      location_item = LocationItem.find_by(location_id: self.id, item_id: item_obj.id)
      location_item.quantity
   end

   def get_location_item(item_obj)
      LocationItem.find_by(location_id: self.id, item_id: item_obj.id)   
   end

end
