class VipRefSummary < ActiveRecord::Base
  validates :summary_text,length: { in: 3..500,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
      
  validates :vip_reference,presence:true
  belongs_to :vip_reference
  belongs_to :creator, class_name: 'User'
end
