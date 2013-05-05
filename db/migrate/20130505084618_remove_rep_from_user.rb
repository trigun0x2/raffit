class RemoveRepFromUser < ActiveRecord::Migration
  def up
  	remove_column :users, :rep
  end

  def down
  	add_column :users, :rep, :integer
  end
end
