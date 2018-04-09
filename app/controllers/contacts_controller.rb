class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :set_office, only: [:new,:index,:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    #@contacts=Contact.all.includes(:designation).order("designation.name DESC").paginate(page: params[:page], per_page: 5)
    if current_user.is_admin? && current_user.contact.office == @office 
      @contacts = Contact.includes(:designation).order('designations.name ASC').all.paginate(page: params[:page], per_page: 10)
    else
      @contacts = Office.find(params[:office_id]).contacts.paginate(page: params[:page], per_page: 10)
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to [@office,@contact], notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to [@office,@contact], notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    if @contact.destroy.destroyed?
      @contact.user.destroy
    end  
    respond_to do |format|
      format.html { redirect_to [@office,@contact], notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_office
      @office = Office.find(params[:office_id])
    end

    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name,:room_no,:office_id,:contact_no,:intercom,:user_id,:designation_id,:active)
    end
end
