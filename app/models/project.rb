class Project < ActiveRecord::Base
  attr_accessible :description, :name, :private

  has_many :members
  has_many :users, through: :members

  has_many :lists
end
