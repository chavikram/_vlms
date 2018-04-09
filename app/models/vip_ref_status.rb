class VipRefStatus < ActiveRecord::Base
  
  validates :status_name,length: { in: 3..10,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
  
  validates :status_desc,length: { in: 3..20,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
  
  
  belongs_to :vip_reference
  scope :default, lambda { where(:default => true).order(:order) }

end

