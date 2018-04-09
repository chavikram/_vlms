class FeedbacksController < ApplicationController
  before_action :set_office, only: [:create,:new,:show,:index,:edit, :update, :destroy]
  before_action :set_feedback, only: [:show,:edit, :update, :destroy]
  before_action :set_contact, only: [:create,:new,:index,:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource
  def new
    @feedback= Feedback.new
  end
  def index
    if current_user.is_admin?
      @feedbacks = Feedback.all.paginate(page: params[:page], per_page: 10)  
    else
    @feedbacks = @contact.feedbacks.paginate(page: params[:page], per_page: 10)
    end
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @feedback= Feedback.new(feedback_params)
    @feedback.contact= current_user.contact
    @feedback.submitted_on= DateTime.now
    respond_to do |format|
      if @feedback.save
        format.html { redirect_to [@office,@contact,@feedback], notice: 'Feedback was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @feedback.update(contact_params)
        format.html { redirect_to [@contact,@feedback], notice: 'Feedback was successfully updated.' }
        format.json { render :show, status: :ok, location: @feedback }
      else
        format.html { render :edit }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @feedback.destroy
        
    respond_to do |format|
      format.html { redirect_to [@office,@contact,@feedback], notice: 'Feedback was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    def set_contact
      @contact = Contact.find(params[:contact_id])
    end
    def set_office
      @office = Office.find(params[:office_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feedback_params
      params.require(:feedback).permit(:feedback_text)
    end

end
