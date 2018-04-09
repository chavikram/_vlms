class AddInchargeIdToOffice < ActiveRecord::Migration
  def change
    add_reference :offices, :incharge,references: :contacts
  end
end
