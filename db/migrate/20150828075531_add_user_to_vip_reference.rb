class AddUserToVipReference < ActiveRecord::Migration
  def change
    add_reference :vip_references, :user, index: true
  end
end
