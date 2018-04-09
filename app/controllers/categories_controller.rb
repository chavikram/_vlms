class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  def index
    @categories = Category.all.paginate(page: params[:page], per_page: 5)
  end
  def destroy
    @category.destroy
    
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def edit
  end
  
  def show
    
  end
  
  def listofSubCategories

    @subcategories = VipCategory.where("category_id = ?",params[:category_id])
    render :json => @subcategories.collect{ |r| {id: "#{r.id}", text: "#{r.name}"} }
  end
  
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category , notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category  }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name,:deleted)
    end

end
