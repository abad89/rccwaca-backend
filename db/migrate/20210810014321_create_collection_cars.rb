class CreateCollectionCars < ActiveRecord::Migration[5.2]
  def change
    create_table :collection_cars do |t|
      t.integer :collection_id
      t.integer :car_id
    end
  end
end
