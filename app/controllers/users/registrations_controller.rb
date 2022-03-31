class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def build_resource(hash={})
    hash[:uid] = User.create_unique_string
    super
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :image, :name, :name_tag, :last_target, :notice, :notice_time ])
  end

  def after_sign_up_path_for(resource)
    blogs_url
  end

  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  # 編集後のページ
  def after_update_path_for(resource)
    user_path(current_user)
  end

end
