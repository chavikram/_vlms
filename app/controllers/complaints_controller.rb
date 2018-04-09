require 'will_paginate/array'
class ComplaintsController < ApplicationController

  before_action :authenticate_user!, except:[:new,:create,:show,:search_form,:search,:index, :home]
  #load_and_authorize_resource
  before_action :set_complaint, only: [:show, :edit, :update, :destroy]

  # GET /complaints
  # GET /complaints.json
  def home
  end  
  
  def index
    @complaints = Complaint.search(params[:search])
    if !current_user.nil? && current_user.is_admin?
      handlerid=current_user.handler.id
      @complaints=Complaint.all.select{|c| c.complaint_movements.empty?}
      @complaintswithmovement=Complaint.all.select{|c| !c.complaint_movements.empty?}
      @complaintswithmovement=@complaintswithmovement.select{|c| c.complaint_movements.last.receiver_id==handlerid}
      @complaints=@complaints.select{|c| c.complaint_type.handler_id==handlerid}
      @complaints=@complaints+@complaintswithmovement
      @complaints=@complaints.sort_by(&:created_at)
      #@complaints = Complaint.all.order('date_since')
    elsif !current_user.nil? 
      if @complaints.empty?
        @complaints = Complaint.all.user(current_user.id).order('date_since')
      else
        @complaints = @complaints.user(current_user.id).order('date_since')
      end
    end
    @complaints=@complaints.paginate(page: params[:page], per_page: 5)
  end
  
  # GET /complaints/1
  # GET /complaints/1.json
  def show
  end

  # GET /complaints/new
  def new
    @complaint = Complaint.new
  end

  # GET /complaints/1/edit
  def edit
  end

  # POST /complaints
  # POST /complaints.json
  def create
    @complaint = Complaint.new(complaint_params)
    if !current_user.nil?
      @complaint.user_id= current_user.id
    end
    @complaint.status_id= Status.first.id
    respond_to do |format|
      if @complaint.save
        format.html { redirect_to @complaint, notice: 'Complaint was successfully created.' }
        format.json { render :show, status: :created, location: @complaint }
      else
        format.html { render :new }
        format.json { render json: @complaint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /complaints/1
  # PATCH/PUT /complaints/1.json
  def update
    respond_to do |format|
      if @complaint.update(complaint_params)
        @complaint.status_id = complaint_params[:status_id]
        format.html { redirect_to @complaint, notice: 'Complaint was successfully updated.' }
        format.json { render :show, status: :ok, location: @complaint }
      else
        format.html { render :edit }
        format.json { render json: @complaint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /complaints/1
  # DELETE /complaints/1.json
  def destroy
    @complaint.destroy
    respond_to do |format|
      format.html { redirect_to complaints_url, notice: 'Complaint was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_complaint
      @complaint = Complaint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def complaint_params
      params.require(:complaint).permit(:complaint_type_id, :remarks, :location, :date_since, :user_id, :status_id, :room_no, :contact_no, :intercom,:name,:complaint_ids,:complaint_statuses_attributes=>[:id,:status_id,:remarks,:_destroy,:handler_id])
    end
end
