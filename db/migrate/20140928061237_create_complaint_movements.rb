class CreateComplaintMovements < ActiveRecord::Migration
  def change
    create_table :complaint_movements do |t|
      t.integer :complaint_id
      t.integer :sender_id
      t.integer :receiver_id
      t.timestamp :on

      t.timestamps
    end
  end
end
