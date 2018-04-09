class VipRefTransfersController < ApplicationController

  before_action :authenticate_user!

  before_action :set_vip_reference, only: [:create, :show, :edit, :update, :destroy,:new]
  before_action :set_vip_ref_transfer, only: [:show, :edit]

  def index
  end
  
  def create
    
    Rails.logger.info "ssdf#{vip_ref_transfer_params[:to]}"
    @vip_ref_transfer = VipRefTransfer.new
    @vip_ref_transfer.vip_reference = @vip_reference
    @vip_ref_transfer.from = @vip_reference.dealing_section
    @vip_ref_transfer.to = Section.find(vip_ref_transfer_params[:to_id])
    @vip_ref_transfer.remarks = vip_ref_transfer_params[:remarks]
    @vip_ref_transfer.transferred_on = Time.now
    @vip_ref_transfer.user_id = current_user.id
    
    respond_to do |format|
      if @vip_ref_transfer.save
        format.html { redirect_to @vip_reference, notice: 'Reference was successfully Transferred.' }
        format.json { render :show, status: :sent, location: @vip_reference }
      else
        format.html { render :new }
        format.json { render json: @vip_ref_transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @vip_ref_transfer = VipRefTransfer.new
    @vip_ref_transfer.vip_reference = @vip_reference
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_vip_reference
    @vip_reference = VipReference.find(params[:vip_reference_id])
  end
  def set_vip_ref_transfer
    @vip_ref_transfer = VipRefTransfer.find(params[:vip_ref_movement_id])
  end  
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def vip_ref_transfer_params
      params.require(:vip_ref_transfer).permit(:to_id,:remarks)
  end

end
