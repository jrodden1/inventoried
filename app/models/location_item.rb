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

   #As it stands, I decided that though this method deals only with item and user objects, it is the location item model's responsibility to make sure it doesn't create a dupe / bad data.  I was torn between leaving it here or putting it in the item model.
   def self.dupe_found(user_obj, item_obj)
      user_obj.items.find {|uitem| uitem.name == item_obj.name}
   end

end
