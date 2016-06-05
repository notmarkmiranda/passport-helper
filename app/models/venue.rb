class Venue < ActiveRecord::Base
  validates :address, presence: true
  validates :name, presence: true, uniqueness: { scope: :address }
  validates :neighborhood, presence: true
end
