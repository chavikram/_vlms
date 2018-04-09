class AddOrderToVipRefStatus < ActiveRecord::Migration
  def change
    add_column :vip_ref_statuses, :order, :integer
  end
end
