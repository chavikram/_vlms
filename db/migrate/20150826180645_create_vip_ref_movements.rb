class CreateVipRefMovements < ActiveRecord::Migration
  def change
    create_table :vip_ref_movements do |t|
      t.integer :sent_to
      t.datetime :sent_on
      t.text :remarks
      t.integer :sent_by
      t.references :vip_reference, index: true

      t.timestamps
    end
  end
end
