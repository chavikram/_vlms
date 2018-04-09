class AddShortNameToVipCategory < ActiveRecord::Migration
  def change
    add_column :vip_categories, :s_name, :string
  end
end
