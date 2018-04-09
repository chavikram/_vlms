class AddDefaultToVipRefStatus < ActiveRecord::Migration
  def change
    add_column :vip_ref_statuses, :default, :boolean
  end
end
