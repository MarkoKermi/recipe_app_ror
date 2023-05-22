class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :foods, class_name: "food", foreign_key: "user_id"
  has_many :recipe, class_name: "recipe", foreign_key: "user_id"

  validates :name, presence: true
end
