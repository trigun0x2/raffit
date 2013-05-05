class AddIdToColumnNames < ActiveRecord::Migration
  def up
  	drop_table :items
  	create_table "items", :force => true do |t|
      t.integer  "user_id"
      t.string   "name"
      t.decimal  "price"
      t.integer  "quantity"
      t.integer  "description"
      t.integer  "tickthres_min"
      t.integer  "tickthres_max"
      t.integer  "tickbuy_min"
      t.integer  "tickbuy_max"
      t.decimal  "shipping"
      t.date     "close_date"
      t.integer  "winning_ticket",	:null => true, :default => nil
      t.datetime "created_at",    :null => false
      t.datetime "updated_at",    :null => false
    end
    change_table :tickets do |t|
      t.rename :user, :user_id
      t.rename :item, :item_id
    end
  end
  
  def down
    change_table :tickets do |t|
      t.rename :user_id, :user
      t.rename :item_id, :item
    end
    drop_table :items
    create_table "items", :force => true do |t|
      t.integer  "user"
      t.string   "name"
      t.decimal  "price"
      t.integer  "quantity"
      t.integer  "description"
      t.integer  "tickthres_min"
      t.integer  "tickthres_max"
      t.integer  "tickbuy_min"
      t.integer  "tickbuy_max"
      t.decimal  "shipping"
      t.date     "closeDate"
      t.integer  "ticket"
      t.datetime "created_at",    :null => false
      t.datetime "updated_at",    :null => false
    end
  end
end
