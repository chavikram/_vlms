class Office < ActiveRecord::Base
  validates :name,length: { in: 3..20,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
  validates :room_no,length: { in: 3..6,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
  validates :incharge_name,length: { in: 3..20,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
      
  validates :parent_office ,presence:true
  validates :designation, presence: true    
  
  default_scope {order('name ASC')}
  has_many :contacts
    
  belongs_to :incharge, class_name: "Contact"
  
  belongs_to :parent_office , :class_name => 'Office'
end
