class AddIntercomToOffice < ActiveRecord::Migration
  def change
    add_column :offices, :intercom, :string
  end
end
