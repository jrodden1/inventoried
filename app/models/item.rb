class Item < ApplicationRecord
   has_many :location_items
   has_many :locations, through: :location_items
   belongs_to :user

   validates :name, presence: true 
   
end
