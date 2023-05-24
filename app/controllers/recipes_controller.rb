class RecipesController < ApplicationController
  before_action :authenticate_user!

  

  def index
    @recipes = Recipe.where(user_id: current_user.id)    
  end

  def new
    @recipe = Recipe.new
  end

  def show
    @user = current_user
    @recipe = Recipe.find(params[:id])
  end

  def create
    @user = current_user
    @recipe = @user.recipes.new(params[:recipe])

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
  rescue ActiveRecord::RecordNotFound
    redirect_to recipes_path, alert: 'The recipe was not deleted'
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    redirect_to recipe_path(@recipe), notice: 'The recipe was updated'
  rescue ActiveRecord::RecordNotFound
    redirect_to recipe_path(@recipe), alert: 'The recipe was not updated'
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
