class Venue < ActiveRecord::Base
  has_many :specials
  has_many :passports, through: :specials
  validates :address, presence: true
  validates :name, presence: true, uniqueness: { scope: :address }
  validates :neighborhood, presence: true

  def passport_specials(passport)
    specials.find_by(passport_id: passport.id).name
  end
end
