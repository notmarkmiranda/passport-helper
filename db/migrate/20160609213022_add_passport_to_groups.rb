class AddPassportToGroups < ActiveRecord::Migration
  def change
    add_reference :groups, :passport, index: true, foreign_key: true
  end
end
