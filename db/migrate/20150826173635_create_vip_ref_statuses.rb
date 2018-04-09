class CreateVipRefStatuses < ActiveRecord::Migration
  def change
    create_table :vip_ref_statuses do |t|
      t.string :status_name
      t.string :status_desc
      t.boolean :deleted

      t.timestamps
    end
  end
end
