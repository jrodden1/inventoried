class User < ApplicationRecord
   has_secure_password
   
   has_many :locations
   has_many :items, through: :locations
   
   validates :name, presence: true
   validates :email, presence: true, uniqueness: true
   
   def items
      #Since items can be in multiple locations, I thought it best to override the basic items method with a unique array of items
      self.items.uniq
   end

end
