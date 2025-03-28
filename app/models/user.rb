class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  ##### Parrainage #####
  has_many :referrals, class_name: "User", foreign_key: "referrer_id"
  belongs_to :referrer, class_name: "User", optional: true

  validates :referral_token, uniqueness: true

  before_create :generate_referral_token
  before_create :match_referrer, if: :ref_from_url
  after_create :create_friendship_with_referrer, if: :referrer

  def generate_referral_token
    begin
      self.referral_token = SecureRandom.hex(8)
    end while User.exists?(referral_token: self.referral_token)
  end

  def match_referrer
    self.referrer = User.find_by(referral_token: ref_from_url)
  end

  def create_friendship_with_referrer
    Friendship.create!(sender: referrer, receiver: self, status: "accepted")
  end


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

    # 👇 Méthode pour savoir si tu es ami avec quelqu’u
    def friend_with?(user)
      friends.include?(user)
    end

    # 👇 Méthode pour savoir si tu as envoyé une demande à quelqu’u
    def sent_request_to?(user)
      pending_friends.include?(user)
    end

    # 👇 Méthode pour savoir si tu as reçu une demande de quelqu’
    def received_request_from?(user)
      incoming_requests.include?(user)
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
