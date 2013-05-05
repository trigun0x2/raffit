class AddIdToColumnNames < ActiveRecord::Migration
  def change
  	change_table :items do |t|
  	  t.rename :user, :user_id
  	  t.rename :closeDate, :close_date
  	  t.rename :ticket, :winning_ticket
  	end
    change_table :tickets do |t|
      t.rename :user, :user_id
      t.rename :item, :item_id
    end
  end
end
