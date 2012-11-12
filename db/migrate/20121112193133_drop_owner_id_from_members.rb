class DropOwnerIdFromMembers < ActiveRecord::Migration
  def up
    remove_column :members, :owner
  end

  def down
    add_column :members, :owner, :boolean
  end
end
