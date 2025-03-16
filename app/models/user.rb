class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :bets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :wallet, dependent: :destroy
end
