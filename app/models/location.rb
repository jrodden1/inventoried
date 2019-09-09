class Location < ApplicationRecord
   belongs_to :user
   belongs_to :items

   validates :name, presence: true
end
