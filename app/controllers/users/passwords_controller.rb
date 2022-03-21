class Users::PasswordsController < Devise::PasswordsController

  def ensure_normal_user
    if params[:user][:email].downcase == 'guest@example.com'
      redirect_to new_user_session_path, notice: t('notice.guest_user_password_cannot_be_reset')
    end
  end
end
