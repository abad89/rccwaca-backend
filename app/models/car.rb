class Car < ActiveRecord::Base
    has_many :collections
    has_many :users, through: :collections
end