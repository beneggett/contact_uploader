class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def social_authorize
    auth = request.env["omniauth.auth"]
    @user = User.find_for_oauth(auth)
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => auth.provider.to_s.titleize ) if is_navigational_format?
    else
      session["devise.#{auth.provider.to_s}_data"] = auth
      redirect_to new_user_registration_url
    end
  end

  alias_method :facebook, :social_authorize
  alias_method :google_oauth2, :social_authorize
  alias_method :github, :social_authorize

end
