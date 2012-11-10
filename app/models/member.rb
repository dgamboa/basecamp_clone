class Member < ActiveRecord::Base
  attr_accessible :owner, :project_id, :user_id

  belongs_to :project
  belongs_to :user
end
