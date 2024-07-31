class CategoriesController < ApplicationController
  before_action :set_category, only: %i[edit update]

  def index
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to user_settings_path, notice: 'Catégorie créée avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      respond_to do |format|
        format.html { redirect_to user_settings_path, notice: 'Catégorie mise à jour avec succès.' }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@category), partial: "categories/form", locals: { category: @category }) }
      end
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
