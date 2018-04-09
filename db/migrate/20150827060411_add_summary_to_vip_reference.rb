class AddSummaryToVipReference < ActiveRecord::Migration
  def change
    add_column :vip_references, :summary, :text
  end
end
