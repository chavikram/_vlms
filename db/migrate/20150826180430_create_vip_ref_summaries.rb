class CreateVipRefSummaries < ActiveRecord::Migration
  def change
    create_table :vip_ref_summaries do |t|
      t.text :summary_text
      t.references :vip_reference, index: true

      t.timestamps
    end
  end
end
