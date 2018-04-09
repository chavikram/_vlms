class AddCategoryToVipCategory < ActiveRecord::Migration
  def change
    add_reference :vip_categories, :category, index: true
  end
end
