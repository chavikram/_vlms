class CreateSenders < ActiveRecord::Migration
  def change
    create_table :senders do |t|
      t.string :name
      t.string :designation
      t.string :org
      t.string :address1
      t.string :address2
      t.string :country
      t.string :state
      t.string :city
      t.string :pincode
      t.string :mobile
      t.string :email
      t.string :landline

      t.timestamps
    end
  end
end
