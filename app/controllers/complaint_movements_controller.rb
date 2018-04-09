class ComplaintMovementsController < ApplicationController
  
  before_action :set_complaint, only: [:create, :show, :edit, :update, :destroy]

  def index
  end

  def create
    cm=ComplaintMovement.new
    cm.sender_id=@complaint.complaint_type.handler.id
    cm.receiver_id= complaint_params[:handler_id]
    cm.on= Time.now
    @complaint.complaint_movements << cm
    respond_to do |format|
      format.js 
    end
  end

  def update
  end

  def delete
  end

  def new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_complaint
      @complaint = Complaint.find(complaint_params[:complaint_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def complaint_params
      params.permit(:complaint_id,:handler_id)
    end
 
end
