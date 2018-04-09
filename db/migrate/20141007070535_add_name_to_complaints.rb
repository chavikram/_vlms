class AddNameToComplaints < ActiveRecord::Migration
  def change
    add_column :complaints, :name, :string
  end
end
