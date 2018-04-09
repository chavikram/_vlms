class AddContactToOffices < ActiveRecord::Migration
  def change
    add_column :offices, :contact_no, :string
    add_column :offices, :mobile, :string
    add_column :offices, :email, :string
  end
end
