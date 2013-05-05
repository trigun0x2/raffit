class ChangeDescriptionToString < ActiveRecord::Migration
  def up
  	change_column :items, :description, :string
  end

  def down
  	change_column :items, :description, :int
  end
end
