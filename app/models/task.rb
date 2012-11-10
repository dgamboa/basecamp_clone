class Task < ActiveRecord::Base
  attr_accessible :author, :description, :doer_id, :due_at, :list_id

  belongs_to :list
end
