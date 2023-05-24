class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :foods, class_name: 'food', foreign_key: 'user_id'
  has_many :recipes, class_name: 'recipe', foreign_key: 'user_id', dependent: :destroy

  validates :name, presence: true
end
