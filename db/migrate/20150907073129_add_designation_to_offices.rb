class AddDesignationToOffices < ActiveRecord::Migration
  def change
    add_column :offices, :designation, :string
  end
end
