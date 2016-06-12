class UserPassport < ActiveRecord::Base
  belongs_to :user
  belongs_to :passport
  has_many :visits, dependent: :destroy
  has_many :venues, through: :visits
  validates :passport_id, presence: true
  validates :user_id, presence: true, uniqueness: { scope: :passport_id, message: "You've already added that passport to your account!" }

  # validates_uniqueness_of :user_id, scope: :passport_id
  def self.lookup(user, passport)
    find_by(user_id: user.id, passport_id: passport.id).id
  end
end
