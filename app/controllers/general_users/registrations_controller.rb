class GeneralUsers::RegistrationsController < Devise::RegistrationsController
  # before_filter :configure_permitted_parameters
  #
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) do |u|
  #     u.permit(:name,:email, :password, :password_confirmation)
  #   end
  # end

  def new
    @general_user = GeneralUser.new

  end

  def create
    #継承元のdeviseのコントローラーの動きはhttps://github.com/plataformatec/deviseを確認すること
    super
  end

  def agreement
  end

end
