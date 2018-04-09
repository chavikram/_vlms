class Designation < ActiveRecord::Base
validates :name,length: { in: 3..20,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
  validates :designation_code,length: { in: 2..6,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
  
  
end
