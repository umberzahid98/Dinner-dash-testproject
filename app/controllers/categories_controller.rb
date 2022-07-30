# frozen_string_literal: true

# category controller
class CategoriesController < ApplicationController
  before_action :set_categories, only: %i[index create]
  before_action :authorize_category, only: %i[index create]
  def index
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.js { flash.now[:notice] = 'Category created successfully' }
      else
        format.js { flash.now[:notice] = 'Category not created!' }
      end
    end
  end

  private

  def authorize_category
    # authorize Category
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_categories
    @categories = Category.all
    @count = 0
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name)
  end
end
