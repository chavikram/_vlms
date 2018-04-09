class AddHandlerIdToComplaintStatuses < ActiveRecord::Migration
  def change
    add_column :complaint_statuses, :handler_id, :integer
  end
end
