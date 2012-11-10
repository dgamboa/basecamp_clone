class List < ActiveRecord::Base
  attr_accessible :project_id, :title

  belongs_to :project
  has_many :tasks
end
