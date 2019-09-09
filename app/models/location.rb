class Location < ApplicationRecord
   belongs_to :user
   belongs_to :location

   validates :name, presence: true
end
