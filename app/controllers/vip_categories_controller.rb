class VipCategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_vip_category, only: [:show, :edit, :update, :destroy,:referencelist]

  # GET /vip_categories
  # GET /vip_categories.json
  def index
    @vip_categories = VipCategory.all.paginate(page: params[:page], per_page: 5)
  end
  def referencelist
      @referencelist= @vip_category.vip_references.pending.paginate(page: params[:page], per_page: 10)
  end
  # GET /vip_categories/1
  # GET /vip_categories/1.json
  def show
  end

  # GET /vip_categories/new
  def new
    @vip_category = VipCategory.new
  end

  # GET /vip_categories/1/edit
  def edit
  end

  # POST /vip_categories
  # POST /vip_categories.json
  def create
    @vip_category = VipCategory.new(vip_category_params)

    respond_to do |format|
      if @vip_category.save
        format.html { redirect_to @vip_category, notice: 'Vip category was successfully created.' }
        format.json { render :show, status: :created, location: @vip_category }
      else
        format.html { render :new }
        format.json { render json: @vip_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vip_categories/1
  # PATCH/PUT /vip_categories/1.json
  def update
    respond_to do |format|
      if @vip_category.update(vip_category_params)
        format.html { redirect_to @vip_category, notice: 'Vip category was successfully updated.' }
        format.json { render :show, status: :ok, location: @vip_category }
      else
        format.html { render :edit }
        format.json { render json: @vip_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vip_categories/1
  # DELETE /vip_categories/1.json
  def destroy
    @vip_category.destroy
    respond_to do |format|
      format.html { redirect_to vip_categories_url, notice: 'Vip category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vip_category
      @vip_category = VipCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vip_category_params
      params.require(:vip_category).permit(:name,:default,:s_name,:category_id)
    end
end
