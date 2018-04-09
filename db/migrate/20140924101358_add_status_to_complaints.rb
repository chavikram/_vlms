class AddStatusToComplaints < ActiveRecord::Migration
  def change
    add_column :complaints, :status_id, :integer
  end
end
