class Item < ApplicationRecord
   has_many :location_items
   has_many :locations, through: :location_items
   belongs_to :user

   validates :name, presence: true 

   #scope method case insensitve item name search
   scope :search, ->(user_id, query) { where("user_id = ? AND lower(name) LIKE ?", user_id, "%#{query.downcase}%") }
   
   def total_qty
      self.location_items.map {|loc_item| loc_item.quantity}.sum
      #this is not super efficient - hits the DB a lot :/ Refactor
   end
   
   def quantity(location)
      LocationItem.find_by(location_id: location.id, item_id: self.id).quantity
   end
   

end
