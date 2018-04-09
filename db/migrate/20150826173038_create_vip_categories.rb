class CreateVipCategories < ActiveRecord::Migration
  def change
    create_table :vip_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
