class CreateVipRefStatusTypes < ActiveRecord::Migration
  def change
    create_table :vip_ref_status_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
