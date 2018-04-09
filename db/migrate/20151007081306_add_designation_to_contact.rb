class AddDesignationToContact < ActiveRecord::Migration
  def change
    add_reference :contacts, :designation, index: true
  end
end
