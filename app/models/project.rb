class Project < ActiveRecord::Base
  attr_accessible :description, :name, :private, :member_emails

  has_many :members
  has_many :users, through: :members
  belongs_to :owner, :class_name => 'User'

  has_many :lists
  after_save :add_members

  def member_emails=(emails)
    @member_emails = emails.split
  end

  def member_emails
    @member_emails ||= users.pluck(:email).join("\n")
  end

  def add_members
    self.users = User.find_all_by_email(member_emails)
  end

  def public?
    !private?
  end
end
