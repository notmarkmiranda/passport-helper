class CreateSpecials < ActiveRecord::Migration
  def change
    create_table :specials do |t|
      t.string :name
      t.references :venue, index: true, foreign_key: true
      t.references :passport, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
