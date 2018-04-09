class VipRefTransfer < ActiveRecord::Base
  belongs_to :from, class_name: "Section"
  belongs_to :to, class_name: "Section"
  
  
   validates :remarks,length: { in: 3..100,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
  validates :from,:to,:user,:vip_reference,presence:true
  
 
  
  belongs_to :user
  belongs_to :vip_reference
end
