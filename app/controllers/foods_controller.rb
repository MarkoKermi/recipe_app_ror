class FoodsController < ApplicationController
  def index
    @user = current_user
    @food = Food.where(user_id: @user.id)
  end

  def new
    @user = current_user
    @food = Food.new
  end

  def create
    @food = Food.new(post_food)
    @food.user_id = current_user.id
    @food.save

    redirect_to user_foods_path
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to user_foods_path
  end

  private

  def post_food
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
