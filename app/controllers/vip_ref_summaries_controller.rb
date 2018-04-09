class VipRefSummariesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_vip_reference, only: [:create, :show, :edit, :update, :destroy,:new,:index]
  before_action :set_vip_ref_summary, only: [:show,:edit,:update,:destroy]  
  def new
    @vip_ref_summary = VipRefSummary.new
    @vip_ref_summary.vip_reference = @vip_reference
    
  end
  def show
    
  end
  def index
      @vip_ref_summaries = @vip_reference.vip_ref_summaries.paginate(page: params[:page], per_page: 10)
            
  end

  def create
    @vip_ref_summary = VipRefSummary.new(vip_ref_summaries_params)
    @vip_ref_summary.creator_id = current_user.id
    @vip_ref_summary.vip_reference = @vip_reference
    
    respond_to do |format|
      if @vip_ref_summary.save
        format.html { redirect_to @vip_reference, notice: 'Reference was successfully Updated.' }
        format.json { render :show, status: :sent, location: @vip_reference }
      else
        format.html { render :new }
        format.json { render json: @vip_ref_summary.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vip_ref_summary.destroy
    respond_to do |format|
      format.html { redirect_to [@vip_reference,@vip_ref_summary], notice: 'Vip Reference Summary was successfully destroyed.' }
      format.json { head :no_content }
    end

  end

  def edit

  end

  def update
    respond_to do |format|
      if @vip_ref_summary.update(vip_ref_summaries_params)
        format.html { redirect_to [@vip_reference,@vip_ref_summary], notice: 'Vip Reference Summary was successfully Updated.' }
        format.json { render :show, status: :sent, location: @vip_ref_summary }
      else
        format.html { render :edit }
        format.json { render json: @vip_ref_summary.errors, status: :unprocessable_entity }
      end
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_vip_ref_summary
    @vip_ref_summary= VipRefSummary.find(params[:id])
  end

  def set_vip_reference
    @vip_reference = VipReference.find(params[:vip_reference_id])
  end

  def vip_ref_summaries_params
      params.require(:vip_ref_summary).permit(:summary_text)
  end

end
