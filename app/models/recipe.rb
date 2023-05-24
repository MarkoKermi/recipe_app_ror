class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  validates :name, presence: true
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :description, presence: true
  validates :public, inclusion: { in: [true, false] }

  def show_description?(current_user)
    public || user.admin? || user == current_user
  end

  def owner?(current_user)
    user == current_user || user.admin?
  end
  
end
