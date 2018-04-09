class AddVipReferenceToSender < ActiveRecord::Migration
  def change
    add_reference :senders, :vip_reference, index: true
  end
end
