class VipRefMovement < ActiveRecord::Base
  self.table_name = "vip_ref_movements"
  validates :remarks,presence:true
  belongs_to :vip_reference
end
