class StatesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_state, only: [:show, :edit, :update, :destroy]
  before_action :set_country
  respond_to :html

  def index
    @states = @country.states.paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def new
    @state = State.new
    @state.country= @country
  end

  def edit
  end

  def create
    @state = State.new(state_params)
    @state.country = @country
    respond_to do |format|
      if @state.save
        format.html { redirect_to [@country,@state], notice: 'State was successfully created.' }
        format.json { render :show, status: :created, location: @state }
      else
        format.html { render :new }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    respond_to do |format|
      if @state.update(state_params)
        format.html { redirect_to [@country,@state] , notice: 'State was successfully updated.' }
        format.json { render :show, status: :ok, location: @state  }
      else
        format.html { render :edit }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @state.destroy
    respond_to do |format|
      format.html { redirect_to [@country,@state], notice: 'State was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_state
      @state = State.find(params[:id])
    end
    def set_country
      @country= Country.find(params[:country_id])
    end
    def state_params
      params.require(:state).permit(:name, :code, :country_id)
    end
end
