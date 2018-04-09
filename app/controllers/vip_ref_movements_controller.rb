class VipRefMovementsController < ApplicationController

  before_action :set_vip_reference, only: [:create, :show, :edit, :update, :destroy,:new]

  def index
  end
  
  def create
    @vip_ref_movement = VipRefMovement.new
    @vip_ref_movement.sent_to = vip_reference_params[:sent_to]
    @vip_ref_movement.remarks = vip_reference_params[:remarks]
    @vip_ref_movement.sent_by = current_user.id
    @vip_ref_movement.sent_on = Time.now
    @vip_ref_movement.vip_reference = @vip_reference
    
    respond_to do |format|
      if @vip_ref_movement.save
        format.html { redirect_to @vip_reference, notice: 'Reference was successfully Sent.' }
        format.json { render :show, status: :sent, location: @vip_reference }
      else
        format.html { render :new }
        format.json { render json: @vip_ref_movement.errors, status: :unprocessable_entity }
      end
    end

  end
  # to be work upon error messages to be 
  def read
      set_vip_ref_movement
      @vip_ref_movement.read_flag=true
      @vip_ref_movement.read_time= Time.now
      set_vip_reference
      if @vip_ref_movement.save
        redirect_to @vip_reference
      else
        redirect_to inbox_vip_ref_app_path
      end
  end  
  
  def new
    @vip_ref_movement = VipRefMovement.new
    @vip_ref_movement.vip_reference = @vip_reference
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  def show
    
  end
  
  def edit
    
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_vip_reference
    @vip_reference = VipReference.find(params[:vip_reference_id])
  end
  def set_vip_ref_movement
    @vip_ref_movement = VipRefMovement.find(params[:vip_ref_movement_id])
  end  
  # Never trust parameters from the scary internet, only allow the white list through.
  def vip_reference_params
      params.require(:vip_ref_movement).permit(:sent_to,:remarks)
  end
  
end

