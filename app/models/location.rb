class Location < ApplicationRecord
   belongs_to :user
   belongs_to :item, optional: true

   validates :name, presence: true
end
