class CategoriesController < ApplicationController

  def index

  end

  def new
    @category = Category.new
    respond_to do |format|
      format.html { render :new, locals: { category: @category } }
    end
  end
  
  def create
    @category = Category.new(**category_params, user: current_user)
    if @category.save
      redirect_to '/', success:'Category saved successfully'
    else
      redirect_to '/categories/new', alert:'Category could not be created'
    end
  end
  private 
  def category_params
    params.require(:category).permit(:name,:icon)
  end
end
