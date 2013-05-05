class ChangeRepDefault < ActiveRecord::Migration
  def up
  	change_column :users, :rep, :integer, :default => 1000
  end

  def down
  	# You can't currently remove default values in Rails
    raise ActiveRecord::IrreversibleMigration, "Can't remove the default"
  end
end
