class DesignationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_designation, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @designations = Designation.all.paginate(page: params[:page], per_page: Rails.application.config.records_per_page)
    respond_with(@designations)
  end

  def show
    respond_with(@designation)
  end

  def new
    @designation = Designation.new
    respond_with(@designation)
  end

  def edit
  end

  def create
    @designation = Designation.new(designation_params)
    @designation.save
    respond_with(@designation)
  end

  def update
    @designation.update(designation_params)
    respond_with(@designation)
  end

  def destroy
    @designation.destroy
    respond_with(@designation)
  end

  private
    def set_designation
      @designation = Designation.find(params[:id])
    end

    def designation_params
      params.require(:designation).permit(:name, :default,:designation_code)
    end
end
