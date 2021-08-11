class User < ActiveRecord::Base
    has_many :collections
    has_many :cars, through: :collections

    # def self.create(*)
    #     super
    #     @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
    #     @collection = Collection.new
    #     @collection.user_id = @id
    #     @collection.save

    # end


    def self.create_with_collection(name)
        user = User.new(name)
        user.save
        collection = Collection.new
        collection.user_id = user.id
        collection.save
        collection_car = CollectionCar.new
        return user
    end

    def add_car(car_id)
        collection_id = self.collections[0].id
        collcar = CollectionCar.new
        collcar.collection_id = collection_id
        collcar.car_id = car_id
        collcar.save
        return collcar
    end
end

