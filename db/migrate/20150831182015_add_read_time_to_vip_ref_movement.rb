class AddReadTimeToVipRefMovement < ActiveRecord::Migration
  def change
    add_column :vip_ref_movements, :read_time, :datetime
  end
end
