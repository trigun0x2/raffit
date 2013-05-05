class AddDefaultToCredits < ActiveRecord::Migration
  def change
  	change_column :users, :credits, :integer, :default => 100
  end
end
