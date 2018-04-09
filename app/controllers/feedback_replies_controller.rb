class FeedbackRepliesController < ApplicationController
  before_action :set_office, only: [:create,:update,:new,:edit,:show]
  before_action :set_contact, only: [:create,:update,:new,:edit,:show]
  before_action :set_feedback, only: [:create,:update,:new,:edit,:show]
  before_action :set_feedback_reply, only: [:edit,:update,:show]
  
  def create
    @feedbackReply= FeedbackReply.new(feedback_reply_params)
    @feedbackReply.feedback= @feedback
    @feedbackReply.replied_on= DateTime.now
    respond_to do |format|
      if @feedbackReply.save
        format.html { redirect_to [@office,@contact,@feedback,@feedbackReply], notice: 'User was successfully Replied.' }
        format.json { render :show, status: :created, location: @feedbackReply }
      else
        format.html { render :new }
        format.json { render json: @feedbackReply.errors, status: :unprocessable_entity }
      end
    end
  end
  def show

  end
  def new
    @feedback_reply= FeedbackReply.new
  end
  
  private
  def set_contact
    @contact = Contact.find(params[:contact_id])
  end
  
  def set_office
    @office = Office.find(params[:office_id])
  end
  
  def set_feedback
    @feedback = Feedback.find(params[:feedback_id])
  end
  
  def set_feedback_reply
    @feedback_reply = FeedbackReply.find(params[:id])
  end
  
  def feedback_reply_params
      params.require(:feedback_reply).permit(:reply_text)
  end
  
end

