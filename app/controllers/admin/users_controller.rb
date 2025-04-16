class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: "User was successfully created."
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "User was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "User was successfully destroyed."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :phone_number, :role, :daily_ads_count, :avatar, :password, :password_confirmation, :ref_from_url, :referrer_id, :referral_token, wallet_attributes: [ :coins, :diamonds ])
  end
end

# create_table "users", force: :cascade do |t|
#   t.string "email", default: "", null: false
#   t.string "encrypted_password", default: "", null: false
#   t.string "reset_password_token"
#   t.datetime "reset_password_sent_at"
#   t.datetime "remember_created_at"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.string "first_name"
#   t.string "last_name"
#   t.string "phone_number"
#   t.string "role", default: "user", null: false
#   t.string "confirmation_token"
#   t.datetime "confirmed_at"
#   t.datetime "confirmation_sent_at"
#   t.string "unconfirmed_email"
#   t.bigint "referrer_id"
#   t.string "referral_token"
#   t.string "ref_from_url"
#   t.integer "daily_ads_count", default: 20, null: false
#   t.string "avatar"
#   t.string "provider"
#   t.string "uid"
#   t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
#   t.index ["email"], name: "index_users_on_email", unique: true
#   t.index ["referrer_id"], name: "index_users_on_referrer_id"
#   t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
# end

# create_table "wallets", force: :cascade do |t|
#   t.decimal "coins"
#   t.decimal "diamonds", precision: 10, scale: 4, default: "0.0"
#   t.bigint "user_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["user_id"], name: "index_wallets_on_user_id"
# end
