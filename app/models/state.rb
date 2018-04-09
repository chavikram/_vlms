class State < ActiveRecord::Base
    
validates :name,length: { in: 3..20,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
  validates :code,length: { in: 2..5,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
  belongs_to :country
  validates :country,presence:true
    default_scope {order('name ASC')}
    
end
