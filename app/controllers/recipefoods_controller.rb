class RecipefoodsController < ApplicationController
  def new
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @food_recipe = RecipeFood.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @food = Food.find_by!(name: params[:food])
    @quantity = params[:quantity]
    @recifood = RecipeFood.new(recipe_id: @recipe.id, food_id: @food.id, quantity: @quantity)
    if @recifood.save
      flash[:success] = 'Object successfully created'
      redirect_to user_recipe_path(current_user, @recipe)
    else
      flash[:error] = 'food does not exist your foodlist, please add it to your foodlist'
      render 'new'
    end
  end

  def destroy
    @recifood = RecipeFood.find(params[:id])
    @recifood.destroy
    flash[:success] = 'Object was successfully deleted.'
    redirect_to user_recipe_path(current_user, @recifood.recipe.id)
  end
end
