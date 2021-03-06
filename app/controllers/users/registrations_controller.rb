class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: %i[update destroy]
  before_action :ensure_admin_user, only: %i[update destroy]
  before_action :back_from_confirm, only: %i[create]

  def ensure_normal_user
    return unless resource.email == 'guest@example.com'

    flash[:warning] = t('notice.guest_user_cannot_be_updated_deleted')
    redirect_to root_path
  end

  def ensure_admin_user
    return unless resource.email == 'admin_guest@example.com'

    flash[:warning] = t('notice.admin_guest_user_cannot_be_updated_deleted')
    redirect_to root_path
  end

  # def confirm
  #   @user = User.new(sign_up_params)
  #   if @user.valid?
  #     render :confirm
  #   else
  #     @minimum_password_length = resource_class.password_length.min
  #     render :new
  #   end
  # end

  def back_from_confirm
    @user = User.new(sign_up_params)
    render :new and return if params[:back]
  end
end
