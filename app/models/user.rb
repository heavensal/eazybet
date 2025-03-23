class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :bets, dependent: :destroy
  has_many :comments, dependent: :destroy

    # Sent = demandes que tu as envoyées
    has_many :sent_friendships, class_name: "Friendship", foreign_key: :sender_id, dependent: :destroy

    # Received = demandes que tu as reçues
    has_many :received_friendships, class_name: "Friendship", foreign_key: :receiver_id, dependent: :destroy

    # Friends que TU as ajoutés et qui ont accepté
    has_many :friends_sent, -> { where(friendships: { status: "accepted" }) }, through: :sent_friendships, source: :receiver

    # Friends qui T’ONT ajouté et que tu as acceptés
    has_many :friends_received, -> { where(friendships: { status: "accepted" }) }, through: :received_friendships, source: :sender

    # 👇 Méthode pour avoir tous les amis fusionnés
    def friends
      (friends_sent + friends_received).uniq
    end

    # 👇 Ceux à qui tu as envoyé une demande (en attente)
    def pending_friends
      sent_friendships.where(status: "pending").map(&:receiver)
    end

    # 👇 Ceux qui t’ont envoyé une demande (en attente)
    def incoming_requests
      received_friendships.where(status: "pending").map(&:sender)
    end


  ############################################################
  # WALLET
  ############################################################
  has_one :wallet, dependent: :destroy

  after_create :create_wallet
  after_create :force_confirm

  def force_confirm
    self.confirm
  end

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
  # FRIENDS
  ############################################################
  def friend_with?(user)
    friends.include?(user)
  end
end
