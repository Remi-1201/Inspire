class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to blogs_path, notice: 'You have successfully logged in as a guest user.'
  end

  def admin_guest_sign_in
    user = User.admin_guest
    sign_in user
    redirect_to blogs_path, notice: 'You have successfully logged in as an admin guest.'
  end

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
