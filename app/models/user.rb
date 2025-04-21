class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
          :omniauthable, omniauth_providers: [ :google_oauth2 ]

  validates :role, presence: true, inclusion: { in: %w[user admin manager] }

  ##### Omniauth ###############################################################
  def self.from_omniauth(auth)
    find_or_initialize_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name   # assuming the user model has a name
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      user
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.google_data"]
        user.email = data["info"]["email"]
        user.first_name = data["info"]["first_name"]
        user.last_name = data["info"]["last_name"]
        user.provider ||= data["provider"]
        user.uid ||= data["uid"]
      end
    end
  end

  def incomplete_profile?
    first_name.blank? || last_name.blank? || phone_number.blank? || ref_from_url.blank?
  end


  ##### AVATAR #################################################################
  mount_uploader :avatar, AvatarUploader

  ##### Follower ###############################################################
  has_one :follower, dependent: :destroy
  after_create :create_follower

  def create_follower
    Follower.create(user: self, instagram: false, telegram: false, x_twitter: false, youtube: false, tiktok: false)
  end

  ##### Ads ####################################################################
  # strictement supérieur ou égal à 0
  validates :daily_ads_count, numericality: { greater_than_or_equal_to: 0 }

  # a chaque fois que le user regarde une pub, on décrémente le nombre de pubs restantes
  # on chaque fois qu'on décrémente on ajoute +250 coins au user.wallet.coins
  # Chaque minuit, on réinitialise le nombre de pubs restantes à 20

  def has_watched_ads
    self.daily_ads_count -= 1
    self.wallet.coins += 250
    self.save!
    self.wallet.save!
  end

  def able_to_watch_ads?
    self.daily_ads_count > 0
  end

  def set_ads_count(count)
    self.daily_ads_count = count
    self.save!
  end
  ##### Parrainage #############################################################
  has_many :referrals, class_name: "User", foreign_key: "referrer_id", dependent: :nullify
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
  ##############################################################################

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
  accepts_nested_attributes_for :wallet

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

  def user?
    role == "user"
  end

  def manager?
    role == "manager"
  end

  ############################################################
  # FRIENDS
  ############################################################
  def friend_with?(user)
    friends.include?(user)
  end
end
