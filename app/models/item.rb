class Item < ApplicationRecord
   has_many :locations
   has_many :users, through: :locations

   validates :name, presence: true 
   validates :quantity, presence: true
end
