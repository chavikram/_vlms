class AddCreatedByToVipRefSummary < ActiveRecord::Migration
  def change
    add_reference :vip_ref_summaries, :creator, references: :users, index: true
  end
end
