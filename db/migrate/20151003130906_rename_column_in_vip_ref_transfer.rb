class RenameColumnInVipRefTransfer < ActiveRecord::Migration
  def change
        rename_column :vip_ref_transfers, :on, :transferred_on
  end
end
