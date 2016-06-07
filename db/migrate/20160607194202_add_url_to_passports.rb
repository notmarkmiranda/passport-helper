class AddUrlToPassports < ActiveRecord::Migration
  def change
    add_column :passports, :url, :string
  end
end
