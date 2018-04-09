class AddReadFlagToVipRefMovement < ActiveRecord::Migration
  def change
    add_column :vip_ref_movements, :read_flag, :boolean
  end
end
