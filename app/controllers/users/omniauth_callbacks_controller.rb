class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :github
  
  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'GitHub') if is_navigational_format?
    else
      session['devise.github_data'] = request.env['omniauth.auth'].except(:extra)
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to new_user_session_url
  end
end
