class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to groups_path, notice: t('notice.guest_user_login')
  end

  def admin_guest_sign_in
    user = User.admin_guest
    sign_in user
    redirect_to root_path, notice: t('notice.admin_guest_user_login')
  end
end