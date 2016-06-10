class AddCityToPassport < ActiveRecord::Migration
  def change
    add_column :passports, :city, :string
  end
end
