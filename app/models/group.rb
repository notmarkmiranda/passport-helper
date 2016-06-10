class Group < ActiveRecord::Base
  include Formatter
  after_create :membership_association

  has_many :memberships
  has_many :users, through: :memberships

  validates :name, presence: true, uniqueness: true
  validates :passport_id, presence: true


  def membership_count
    users.count
  end

  private
  def membership_association
    Membership.create(group_id: self.id, user_id: self.user_id)
  end
end
