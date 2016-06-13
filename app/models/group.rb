class Group < ActiveRecord::Base
  include Formatter
  after_create :membership_association

  belongs_to :passport
  has_many   :venues, through: :passport
  has_many   :memberships
  has_many   :users, through: :memberships

  validates :name, presence: true, uniqueness: true
  validates :passport_id, presence: true

  after_create :clear_cache
  after_save :clear_cache
  after_destroy :clear_cache

  def clear_cache
    Rails.cache.clear
  end


  def membership_count
    users.count
  end

  private
  def membership_association
    Membership.create(group_id: self.id, user_id: self.user_id)
  end
end
