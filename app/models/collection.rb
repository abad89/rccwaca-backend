class Collection < ActiveRecord::Base
    has_many :collection_cars
    has_many :cars, through: :collection_cars
    belongs_to :user
end