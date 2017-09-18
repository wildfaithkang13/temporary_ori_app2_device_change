class GeneralUsers::RegistrationsController < Devise::RegistrationsController
  def new
    @general_user = GeneralUser.new
  end

  def create
    #継承元のdeviseのコントローラーの動きはhttps://github.com/plataformatec/deviseを確認すること
    super
  end
end
