class AddExtraFieldsToComplaints < ActiveRecord::Migration
  def change
    add_column :complaints, :room_no, :string
    add_column :complaints, :contact_no, :string
    add_column :complaints, :intercom, :string
  end
end
