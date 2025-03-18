class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :bets, dependent: :destroy
  has_many :comments, dependent: :destroy


  ############################################################
  # WALLET
  ############################################################
  has_one :wallet, dependent: :destroy

  after_create :create_wallet

  def create_wallet
    Wallet.create(user: self, diamonds: 0, coins: 1000)
  end
  ############################################################


  ############################################################
  # ROLE
  ############################################################
  def admin?
    role == "admin"
  end

  ############################################################
end
