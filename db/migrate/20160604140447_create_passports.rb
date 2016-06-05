class CreatePassports < ActiveRecord::Migration
  def change
    create_table :passports do |t|
      t.string :name
      t.date :start
      t.date :expiration
      t.string :status

      t.timestamps null: false
    end
  end
end
