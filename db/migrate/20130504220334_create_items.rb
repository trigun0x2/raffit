class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :user
      t.string :name
      t.decimal :price
      t.integer :quantity
      t.integer :description
      t.integer :tickthres_min
      t.integer :tickthres_max
      t.integer :tickbuy_min
      t.integer :tickbuy_max
      t.decimal :shipping
      t.date :closeDate
      t.integer :ticket

      t.timestamps
    end
  end
end
