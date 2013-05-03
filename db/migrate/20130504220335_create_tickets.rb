class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :user
      t.integer :item

      t.timestamps
    end
  end
end
