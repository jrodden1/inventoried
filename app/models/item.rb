class Item < ApplicationRecord
   has_many :locations
   has_many :users, through: :locations

   validates :name, presence: true 

   def quantity
      binding.pry
   end
   def qty
      binding.pry
   end

   
end
