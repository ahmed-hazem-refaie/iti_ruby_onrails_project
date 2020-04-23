# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
        # auth = request.env["omniauth.auth"]
        @user = User.from_omniauth(request.env["omniauth.auth"])

        # user = User.where(provider: auth["provider"], uid: auth["uid"])
                # .first_or_initialize(email: auth["info"]["email"])
        # user.name ||= auth["info"]["name"]
        # user.save!

        # user.remember_me = true
        sign_in(:user, @user)

        redirect_to after_sign_in_path_for(@user)
    end

    def facebook
        @user = User.from_omniauth(request.env["omniauth.auth"])
        if @user.persisted?
            sign_in_and_redirect @user, :event => :authentication
            set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
        else
            session["devise.facebook_data"] = request.env["omniauth.auth"]
            redirect_to new_user_registration_url
        end
    end

    def failure
        redirect_to root_path
    end
end
