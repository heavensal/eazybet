# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end


  # POST /resource
  # def create
  #   super do |resource|
  #     ref_token = sign_up_params[:ref_from_url]
  #     if ref_token.present?
  #       if referrer = User.find_by(referral_token: ref_token)
  #         resource.referrer = referrer
  #       else
  #         resource.errors.add(:base, "Le lien de parrainage est invalide.")
  #         return respond_with resource
  #       end
  #     end
  #   end
  # end


  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  #

  private

  def assign_referrer
    return unless session[:ref].present?
    build_resource(sign_up_params) unless resource

    referrer = User.find_by(referral_token: session[:ref])

    if referrer
      resource.referrer = referrer
    else
      resource.errors.add(:base, "Le lien de parrainage est invalide.")
      respond_with resource and return
    end
  end
end
