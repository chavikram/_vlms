class AddComplaintIdToComplaintStatuses < ActiveRecord::Migration
  def change
    add_column :complaint_statuses, :complaint_id, :integer
  end
end
