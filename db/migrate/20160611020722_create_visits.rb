class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :venue, index: true, foreign_key: true
      t.references :user_passport, index: true, foreign_key: true
    end
  end
end
