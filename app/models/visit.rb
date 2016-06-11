class Visit < ActiveRecord::Base
  belongs_to :user_passport
  belongs_to :venue

end
