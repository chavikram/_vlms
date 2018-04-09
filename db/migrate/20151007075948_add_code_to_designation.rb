class AddCodeToDesignation < ActiveRecord::Migration
  def change
    add_column :designations, :designation_code, :string
  end
end
