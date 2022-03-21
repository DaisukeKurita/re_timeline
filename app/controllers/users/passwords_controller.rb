class Users::PasswordsController < Devise::PasswordsController
  before_action :ensure_normal_user, only: :create
  before_action :ensure_admin_user, only: :create

  def ensure_normal_user
    if params[:user][:email].downcase == 'guest@example.com'
      redirect_to new_user_session_path, notice: t('notice.guest_user_password_cannot_be_reset')
    end
  end

  def ensure_admin_user
    if params[:user][:email].downcase == 'admin_guest@example.com'
      redirect_to root_path, notice: t('notice.admin_guest_user_password_cannot_be_reset')
    end
  end
end
