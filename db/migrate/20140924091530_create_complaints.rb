class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.integer :complaint_type_id
      t.string :remarks
      t.string :location
      t.date :date_since
      t.integer :user_id

      t.timestamps
    end
  end
end
