class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: %i[update destroy]
  before_action :ensure_admin_user, only: %i[update destroy]

  def ensure_normal_user
    if resource.email == 'guest@example.com'
      redirect_to root_path, notice: t('notice.guest_user_cannot_be_updated_deleted')
    end
  end

  def ensure_admin_user
    if resource.email = 'admin_guest@example.com'
      redirect_to root_path, notice: t('notice.admin_guest_user_cannot_be_updated_deleted')
    end
  end
end