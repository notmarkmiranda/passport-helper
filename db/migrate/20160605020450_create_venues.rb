class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :neighborhood
      t.string :website

      t.timestamps null: false
    end
  end
end
