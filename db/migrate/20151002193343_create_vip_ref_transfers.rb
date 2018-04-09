class CreateVipRefTransfers < ActiveRecord::Migration
  def change
    create_table :vip_ref_transfers do |t|
      t.references :from, index: true
      t.references :to, index: true
      t.string :remarks
      t.datetime :on
      t.references :user, index: true
      t.references :vip_reference, index: true

      t.timestamps
    end
  end
end
