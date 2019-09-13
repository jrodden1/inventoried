class Item < ApplicationRecord
   has_many :location_items
   has_many :locations, through: :location_items
   belongs_to :user

   validates :name, presence: true 

   scope :search, ->(user_id, query) { where("user_id = ? AND name LIKE ?", user_id, "%#{query}%") }
   
   def total_qty
      self.location_items.map {|loc_item| loc_item.quantity}.sum
      #this is not super efficient - hits the DB a lot :/ Refactor
   end
   
   
end
