class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :room_no
      t.integer :office_id
      t.string :contact_no
      t.string :intercom

      t.timestamps
    end
  end
end
