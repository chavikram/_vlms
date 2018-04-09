class CreateHandlers < ActiveRecord::Migration
  def change
    create_table :handlers do |t|
      t.string :name
      t.string :room_no
      t.string :floor
      t.string :contact_no
      t.string :intercom

      t.timestamps
    end
  end
end
