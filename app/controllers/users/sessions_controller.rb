class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest
    guest_id = User.find_by(email: 'guest@example.com').id
    unless Grouping.where(user_id: guest_id).present?
      num = 0
      5.times do
        num += 1
        Grouping.create(user_id: guest_id, group_id: num, admin: true)
      end
    end
    sign_in user
    redirect_to groups_path, notice: t('notice.guest_user_login')
  end

  def admin_guest_sign_in
    user = User.admin_guest
    sign_in user
    redirect_to root_path, notice: t('notice.admin_guest_user_login')
  end
end
