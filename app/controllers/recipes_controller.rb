class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def create
    @user = current_user
    @recipe = @user.recipe.new(params[:recipe])

    if @recipe.save
      redirect_to recipe_path, notice: 'The recipe was succesfuly created'
    else
      render :new, alert: 'The recipe was not created'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipe_path, notice: 'The recipe was deleted'
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
