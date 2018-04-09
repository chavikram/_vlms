class AddDefaultToVipCategory < ActiveRecord::Migration
  def change
    add_column :vip_categories, :default, :boolean
  end
end
