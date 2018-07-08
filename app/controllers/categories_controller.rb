class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "#{@category.name} added!"
      redirect_to category_path(@category)
    else
      flash[:failure] = "Sorry, that category name already exists!"
      redirect_to new_category_path
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  # def edit
  #   @category = Category.find(params[:id])
  # end
  #
  # def update
  #   @category = Category.find(params[:id])
  #   @category.update(category_params)
  #   if @category.save
  #     flash[:success] = "#{@category.name} updated!"
  #     redirect_to category_path(@category)
  #   else
  #     render :edit
  #   end
  # end
  #
  # def destroy
  #   category = Category.find(params[:id])
  #   category.destroy
  #
  #   flash[:success] = "#{category.name} was successfully deleted!"
  #   redirect_to categories_path
  # end
  #
  #
  private

  def category_params
    params.require(:category).permit(:name)
  end
end
