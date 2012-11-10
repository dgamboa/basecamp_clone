class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.boolean :private, default: false

      t.timestamps
    end
  end
end
