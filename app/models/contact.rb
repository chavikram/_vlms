class Contact < ActiveRecord::Base
  validates :name,length: { in: 3..20,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
  validates :room_no,length: { in: 3..6,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
      },presence:true
  validates :designation,:office,presence: true    
  
  validates :contact_no,length: { in: 3..11,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
  },presence:true,numericality: true

  validates :intercom,length: { in: 3..6,
    too_short: "must have at least %{count} characters",
    too_long: "must have at most %{count} characters"
  },presence:true,numericality: true
  
  #default_scope { order('name ASC') }
  belongs_to :user
  belongs_to :office
  belongs_to :designation
  has_many :feedbacks 

end
