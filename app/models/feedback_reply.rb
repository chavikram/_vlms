class FeedbackReply < ActiveRecord::Base
  
  belongs_to :feedback
  validates :reply_text,length: { maximum: 100,
    
    too_long: "must have at most %{count} characters"
      },presence:true
  validates :feedback,presence:true 
  
end
