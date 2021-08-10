class User < ActiveRecord::Base
    has_many :collections
    has_many :cars, through: :collections
end