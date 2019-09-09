class Location < ApplicationRecord
   belongs_to :user
   has_many :location_items
   has_many :items, through: :location_items

   validates :name, presence: true
end
