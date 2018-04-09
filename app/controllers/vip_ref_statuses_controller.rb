class VipRefStatusesController < ApplicationController
  before_action :set_vip_ref_status, only: [:show, :edit, :update, :destroy]

  # GET /vip_ref_statuses
  # GET /vip_ref_statuses.json
  def index
    @vip_ref_statuses = VipRefStatus.all
  end

  # GET /vip_ref_statuses/1
  # GET /vip_ref_statuses/1.json
  def show
  end

  # GET /vip_ref_statuses/new
  def new
    @vip_ref_status = VipRefStatus.new
  end

  # GET /vip_ref_statuses/1/edit
  def edit
  end

  # POST /vip_ref_statuses
  # POST /vip_ref_statuses.json
  def create
    @vip_ref_status = VipRefStatus.new(vip_ref_status_params)

    respond_to do |format|
      if @vip_ref_status.save
        format.html { redirect_to @vip_ref_status, notice: 'Vip ref status was successfully created.' }
        format.json { render :show, status: :created, location: @vip_ref_status }
      else
        format.html { render :new }
        format.json { render json: @vip_ref_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vip_ref_statuses/1
  # PATCH/PUT /vip_ref_statuses/1.json
  def update
    respond_to do |format|
      if @vip_ref_status.update(vip_ref_status_params)
        format.html { redirect_to @vip_ref_status, notice: 'Vip ref status was successfully updated.' }
        format.json { render :show, status: :ok, location: @vip_ref_status }
      else
        format.html { render :edit }
        format.json { render json: @vip_ref_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vip_ref_statuses/1
  # DELETE /vip_ref_statuses/1.json
  def destroy
    @vip_ref_status.destroy
    respond_to do |format|
      format.html { redirect_to vip_ref_statuses_url, notice: 'Vip ref status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vip_ref_status
      @vip_ref_status = VipRefStatus.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def vip_ref_status_params
      params.require(:vip_ref_status).permit(:status_name,:status_desc,:deleted,:default)
    end
end
