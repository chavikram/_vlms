class VipReferencesController < ApplicationController
  
  include VipReferencesHelper
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_vip_reference, only: [:show, :edit, :update, :destroy]
  
  def move_to_inbox
    @vip_reference= VipReference.find(params[:id])
    if @vip_reference.vip_ref_transfers.count !=0
      flash[:notice] = 'already transferred '
      redirect_to :controller=> :vip_ref_app, :action => :inbox_section
    end  
    @vip_ref_transfer=VipRefTransfer.new
    @vip_ref_transfer.vip_reference= @vip_reference
    @vip_ref_transfer.to= Section.find(params[:section_id])
    @vip_ref_transfer.from= Section.find(params[:section_id])
    @vip_ref_transfer.user_id= current_user.id
    @vip_ref_transfer.transferred_on = Time.now
    @vip_ref_transfer.transferred_on = Time.now
    @vip_ref_transfer.remarks = "move to inbox"

    respond_to do |format|
      if @vip_ref_transfer.save
        @vip_reference.vip_ref_status = VipRefStatus.find_by_status_name('Pending')
        @vip_reference.save
        format.html { redirect_to @vip_reference, notice: 'Reference was successfully moved to pending.' }
        format.json { render :show, status: :created, location: @vip_reference }
      else
        format.html { render :index }
        format.json { render json: @vip_reference.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    authorize @vip_reference
  end
  
  def report
    @vip_references=VipReference.all
  end
  
  def transfer
    @vip_reference= VipReference.find(params[:id])
    @vip_ref_transfer=VipRefTransfer.new
    @vip_ref_transfer.vip_reference= @vip_reference
  end
    
  def index
      @vip_references = VipReference.all

      if !current_user.is_admin?
        @vip_references=@vip_references.where("section_id in (?)",current_user.sections.ids)
      end        
      
      if params.has_key?(:section_id) && params[:section_id]!='0'
          @vip_references=@vip_references.where('section_id'=>params[:section_id])
      end
      if params.has_key?(:vip_ref_status_id) && params[:vip_ref_status_id]!='0'
        @vip_references=@vip_references.where('vip_ref_status_id'=>params[:vip_ref_status_id])
      end  
      
      if params.has_key?(:vip_category_id) && params[:vip_category_id]!='0'
        @vip_references=@vip_references.where('vip_category_id'=>params[:vip_category_id])
      elsif params[:vip_category_id]=='0'
        @vip_references=@vip_references.where('vip_category_id in (?)',VipCategory.where("category_id = ?",params[:category_id]).collect(&:id))
      end
      
      if params.has_key?(:vip_ref_id) && params[:vip_ref_id]!='0' && params[:vip_ref_id]!=''
        @vip_references=@vip_references.where('id'=>params[:vip_ref_id])
      end
      if params.has_key?(:subject) && params[:subject]!='0' && params[:subject]!=''
        @vip_references=@vip_references.where("subject ilike ?","%#{params[:subject]}%")
      end
      
      if params.has_key?(:diary_date_from) && params.has_key?(:diary_date_to)
        if !params[:diary_date_from].empty? && !params[:diary_date_from].empty?  
          from=Date.strptime(params[:diary_date_from],"%d/%m/%Y")
          to=Date.strptime(params[:diary_date_to],"%d/%m/%Y")
          @vip_references=@vip_references.where(:diaried_date=> from .. to)
        end
      end    

      @vip_references=@vip_references.uniq.order(diaried_date: :asc)
      @vip_references_for_pdf=@vip_references
      @vip_references=@vip_references.paginate(page: params[:page], per_page: 10)
      if request.query_string == ''
        @vip_references=[].paginate(page: params[:page], per_page: 10)
      end
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @vip_references}
        format.csv { render text: @vip_references.to_csv }
        format.xls 
        format.xlsx

        format.pdf do
          render :pdf => "Vip References Status Report as on #{l Time.now}",
                 :template => 'vip_references/search.pdf.haml',
                 :layout => 'vip_references/pdflayout.pdf.haml',
                  :orientation => 'Landscape',
                  :page_size => 'A4',
                  :footer=>{
                     :center => "VIP References Monitoring System ",
                    :left => "#{l Time.now}",
                    :right => "Developed by CAID,NIC,M/o CA",
                    :font_size=>10,
                  },
                 :margin => {:top=>5,:bottom=>10}
        end         
      end
  end
  
  def edit
    @subcategories = VipCategory.where("category_id = ?",@vip_reference.vip_category.category.id)
  end  
  
  def create
    @vip_reference = VipReference.new(vip_reference_params)
    @vip_reference.user= current_user
    respond_to do |format|
      if @vip_reference.save
        format.html { redirect_to @vip_reference, notice: 'Reference was successfully created.' }
        format.json { render :show, status: :created, location: @vip_reference }
      else
        format.html { render :new }
        format.json { render json: @vip_reference.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @vip_reference.update(vip_reference_params)
        format.html { redirect_to @vip_reference, notice: 'Reference was successfully updated.' }
        format.json { render :show, status: :updated, location: @vip_reference }
      else
        format.html { render :new }
        format.json { render json: @vip_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vip_reference.destroy
    respond_to do |format|
      format.html { redirect_to vip_references_url, notice: 'vip reference was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new
    @vip_reference=VipReference.new
    @vip_reference.sender=@vip_reference.build_sender        
  end
      
  private 
  def set_vip_reference
      @vip_reference = VipReference.find(params[:id])
  end

  def vip_reference_params
      params.require(:vip_reference).permit(:id,:letter_no, :letter_date, :subject, :diaried_date, :diaried_by, 
            :sender_name,:section_id,:vip_ref_status_id,:vip_category_id,:received_on,:eoffice_receipt_no,
            :eoffice_file_no,:deleted,:summary,:sender_attributes => [:id,:name,:designation,:org,:address1,:address2,:country,:state,:pincode,:email,:mobile,:landline,:city])
  end
end
