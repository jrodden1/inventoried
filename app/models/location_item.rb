class LocationItem < ApplicationRecord
   belongs_to :location
   belongs_to :item

   validate :no_dupe_items_in_a_location

   validates :quantity, presence: true

   def no_dupe_items_in_a_location
      !LocationItem.where("location_id = ? AND item_id = ?", self.location_id, self.item_id)
   end
   
   # def quantity
   #    self.quantity
   # end
   
end
