class GeneralUsers::RegistrationsController < Devise::RegistrationsController
  def new
    @general_user = GeneralUser.new
  end
end
