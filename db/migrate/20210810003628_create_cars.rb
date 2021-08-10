class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :name
      t.string :manufacturer
      t.integer :price
      t.string :img_url
    end
  end
end
