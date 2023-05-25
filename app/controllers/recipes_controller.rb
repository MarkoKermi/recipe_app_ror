class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @recipes = Recipe.where(user_id: current_user.id)
  end

  def new
    @user = current_user
    @recipe = Recipe.new
  end

  def create
    @user = current_user
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = @user.id

    if @recipe.save
      redirect_to user_recipes_path, notice: 'The recipe was succesfuly created'
    else
      render :new, alert: 'The recipe was not created'
    end
  end

  def show
    @user = current_user
    @recipe = Recipe.find(params[:id])
    @recifoods = RecipeFood.includes(:food).where(recipe_id: params[:id])
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to user_recipes_path(current_user.id), notice: 'The recipe was deleted'
  end

  def public
    @user = current_user
    @recipes = Recipe.where(public: true)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
