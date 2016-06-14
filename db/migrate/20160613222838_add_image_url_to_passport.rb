class AddImageUrlToPassport < ActiveRecord::Migration
  def change
    add_column :passports, :image_url, :string
  end
end
