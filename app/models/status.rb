class Status < ActiveRecord::Base
  validates :type,length: { in: 3..20,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
  
    belongs_to :complaint
    has_many :complaint_status    
    self.inheritance_column = nil
end
