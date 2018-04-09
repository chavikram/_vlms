class Feedback < ActiveRecord::Base

  validates :feedback_text,length: { maximum: 100,
    
    too_long: "must have at most %{count} characters"
      },presence:true
  
  belongs_to :contact
  validates :contact,presence:true 

  has_many :feedback_replies
end
