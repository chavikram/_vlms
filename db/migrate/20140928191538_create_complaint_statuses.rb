class CreateComplaintStatuses < ActiveRecord::Migration
  def change
    create_table :complaint_statuses do |t|
      t.integer :status_id
      t.string :remarks
      t.timestamp :on

      t.timestamps
    end
  end
end
