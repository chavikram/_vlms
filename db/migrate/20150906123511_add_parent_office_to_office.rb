class AddParentOfficeToOffice < ActiveRecord::Migration
  def change
    add_reference :offices, :parent_office, referencs: :offices, index: true
  end
end
