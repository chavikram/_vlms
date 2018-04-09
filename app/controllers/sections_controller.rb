class SectionsController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_section, only: [:show, :edit, :update, :destroy,:pending_lessthan_1mth,:pending_lessthan_3mth,:pending_morethan_3mth]

  # GET /sections
  # GET /sections.json
  def index
    @sections = Section.all.paginate(page: params[:page], per_page: 5)
  end
  def updated_today
    if current_user.is_admin?
      @x=current_user.sections
    else
      @x=current_user.sections.select{|s| s.id == @section.id}  
    end
    
    if @x.size>0 
      @vip_references=@section.vip_references.updated_today.vip.paginate(page: params[:page], per_page: 10)
      render "updatedtoday"
    else
      @vip_references=[].paginate(page: params[:page], per_page: 10)
      render :text => "You are not authorised!!", :layout=>'application'
    end 
    
  end
  def pending_lessthan_1mth
    if current_user.is_admin?
      @x=current_user.sections
    else
      @x=current_user.sections.select{|s| s.id == @section.id}  
    end
    
    if @x.size>0 
      @vip_references=@section.vip_references.pending_lessthan_1mth.vip.paginate(page: params[:page], per_page: 10)
      render "listview"
    else
      @vip_references=[].paginate(page: params[:page], per_page: 10)
      render :text => "You are not authorised!!", :layout=>'application'
    end 
      
  end
  def pending_lessthan_3mth
     if current_user.is_admin?
      @x=current_user.sections
    else
      @x=current_user.sections.select{|s| s.id == @section.id}  
    end
    
    if @x.size>0 
    @vip_references=@section.vip_references.pending_lessthan_3mth.vip.paginate(page: params[:page], per_page: 10)
      render "listview"
    else
      @vip_references=[].paginate(page: params[:page], per_page: 10)
      render :text => "You are not authorised!!", :layout=>'application'
    end 
  end
  
  def pending_morethan_3mth
     if current_user.is_admin?
      @x=current_user.sections
    else
      @x=current_user.sections.select{|s| s.id == @section.id}  
    end
    
    if @x.size>0 
    @vip_references=@section.vip_references.pending_morethan_3mth.vip.paginate(page: params[:page], per_page: 10)
      render "listview"
    else
      @vip_references=[].paginate(page: params[:page], per_page: 10)
      render :text => "You are not authorised!!", :layout=>'application'
    end 
  end
  
  # GET /sections/1
  # GET /sections/1.json
  def show
  end

  # GET /sections/new
  def new
    @section = Section.new
  end

  # GET /sections/1/edit
  def edit
  end

  # POST /sections
  # POST /sections.json
  def create
    @section = Section.new(section_params)

    respond_to do |format|
      if @section.save
        format.html { redirect_to @section, notice: 'Section was successfully created.' }
        format.json { render :show, status: :created, location: @section }
      else
        format.html { render :new }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sections/1
  # PATCH/PUT /sections/1.json
  def update
    respond_to do |format|
      if @section.update(section_params)
        format.html { redirect_to @section, notice: 'Section was successfully updated.' }
        format.json { render :show, status: :ok, location: @section }
      else
        format.html { render :edit }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    @section.destroy
    respond_to do |format|
      format.html { redirect_to sections_url, notice: 'Section was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def section_params
      params.require(:section).permit(:name,:short_name,:sectionofficer_id,:undersecretary_id,:director_id,:js_id)
    end
end
