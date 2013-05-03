class AddRepToUser < ActiveRecord::Migration
  def change
    add_column :users, :rep, :integer
  end
end
