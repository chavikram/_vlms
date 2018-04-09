class CreateComplaintTypes < ActiveRecord::Migration
  def change
    create_table :complaint_types do |t|
      t.string :problem
      t.string :solution
      t.integer :handler_id
      t.string :level

      t.timestamps
    end
  end
end
