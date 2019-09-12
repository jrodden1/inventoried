class User < ApplicationRecord
   has_secure_password
   
   has_many :items
   has_many :locations
   has_many :location_items, through: :locations
   
   validates :name, presence: true
   validates :email, presence: true, uniqueness: true

   def self.find_or_create_by_facebook_omniauth(auth)
      user = User.find_by(email: auth['info']['email'])
      # user = User.find_or_create_by()
      if user.uid.nil?
         user.update(uid: auth['uid'])
      elsif user.nil?
         user = User.create(email: auth['info']['email'], name: auth['info']['name'], password: SecureRandom.hex, uid: auth['uid'])
      end
   end
   

end
