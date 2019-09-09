class Item < ApplicationRecord
   has_many :location_items
   has_many :locations, through: :location_items
   has_many :users, through: :locations

   validates :name, presence: true 
   
end
