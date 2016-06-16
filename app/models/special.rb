class Special < ActiveRecord::Base
  belongs_to :venue
  belongs_to :passport

  validates :name, presence: true
  validates :venue_id, presence: true
  validates :passport_id, presence: true
  validates :passport_id, uniqueness: { scope: :venue_id }
end
