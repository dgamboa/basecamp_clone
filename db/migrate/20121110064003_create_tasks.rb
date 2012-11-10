class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :list_id
      t.string :description
      t.integer :doer_id
      t.datetime :due_at
      t.integer :author

      t.timestamps
    end
  end
end
