class AddComplaintIdToComplaintStatus < ActiveRecord::Migration
  def change
    add_column :complaint_statuses, :compliant_id, :integer
  end
end
