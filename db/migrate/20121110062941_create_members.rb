class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :project_id
      t.integer :user_id
      t.boolean :owner, default: false

      t.timestamps
    end
  end
end
