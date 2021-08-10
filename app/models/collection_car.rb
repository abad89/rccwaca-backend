class CollectionCar < ActiveRecord::Base
    belongs_to :collection
    belongs_to :car
end