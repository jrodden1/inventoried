class LocationItem < ApplicationRecord
   belongs_to :location
   belongs_to :item

   validates :quantity, presence: true

   def item_name
      self.item.name
   end

   def item_description
      self.item.description
   end
end
