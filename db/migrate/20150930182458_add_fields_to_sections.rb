class AddFieldsToSections < ActiveRecord::Migration
  def change
    add_reference :sections, :sectionofficer,references: :users
    add_reference :sections, :undersecretary,references: :users
    add_reference :sections, :director,references: :users
    add_reference :sections, :js,references: :users
  end
end
