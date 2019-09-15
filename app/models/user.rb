class User < ApplicationRecord
   has_secure_password
   
   has_many :items
   has_many :locations
   has_many :location_items, through: :locations
   
   validates :name, presence: true
   validates :email, presence: true, uniqueness: true

   def self.find_or_create_by_facebook_omniauth(auth)
      #see if I have an existing user to match up with first. 
      user = User.find_by(email: auth['info']['email'])

      #if I don't find a user, then create one from scratch
      if user.nil?
         user = User.create(email: auth['info']['email'], name: auth['info']['name'], password: SecureRandom.hex, uid: auth['uid'])
      elsif user.uid.nil?
      #if I did find an existing user with the same email, then just set the uid.
         user.update(uid: auth['uid'])
         user
      end
      user
   end
end
