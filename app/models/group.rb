class Group < ActiveRecord::Base
  include Formatter
  
  has_many :memberships
  has_many :users, through: :memberships

  validates :name, presence: true, uniqueness: true

  def membership_count
    users.count
  end
end
