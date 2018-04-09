class CountriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_country, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @countries = Country.all.paginate(page: params[:page], per_page: Rails.application.config.records_per_page)
  end
  
  def update_states
  @states = State.where("country_id = ?", params[:country_id])
    respond_to do |format|
      format.js
    end
  end

  def show
  end

  def new
    @country = Country.new
  end

  def edit
  end

  def create
    @country = Country.new(country_params)
    respond_to do |format|
      if @country.save
        format.html { redirect_to @country, notice: 'Country was successfully created.' }
        format.json { render :show, status: :created, location: @country }
      else
        format.html { render :new }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @country.update(country_params)
        format.html { redirect_to @country , notice: 'Country was successfully updated.' }
        format.json { render :show, status: :ok, location: @country  }
      else
        format.html { render :edit }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @country.destroy
    respond_to do |format|
      format.html { redirect_to countries_url, notice: 'Country was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_country
      @country = Country.find(params[:id])
    end

    def country_params
      params.require(:country).permit(:name, :code)
    end
end
