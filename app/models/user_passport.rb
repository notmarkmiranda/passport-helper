class UserPassport < ActiveRecord::Base
  belongs_to :user
  belongs_to :passport
  validates :user_id, presence: true
  validates :passport_id, presence: true
  
  validates_uniqueness_of :user_id, scope: :passport_id
end
