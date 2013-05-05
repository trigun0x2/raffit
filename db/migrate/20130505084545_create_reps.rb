class CreateReps < ActiveRecord::Migration
  def change
    create_table :reps do |t|
      t.integer :voter_id
      t.integer :user_id
      t.integer :vote

      t.timestamps
    end
  end
end
