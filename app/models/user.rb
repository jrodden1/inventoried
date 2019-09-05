class User < ApplicationRecord
   has_secure_password
   
   has_many :locations
   has_many :items, through: :locations
   
   validates :name, presence: true
   validates :email, presence: true, uniqueness: true
   
end
