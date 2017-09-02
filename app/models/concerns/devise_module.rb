module DeviseModule

  def current_user
      #@current_admin ||= current_user if user_signed_in? and current_user.class.name == "Admin"
      #binding.pry ここでストップがかかる
  end


def account_url
  return new_user_session_url unless user_signed_in?
  case current_user.class.name
  when "User"
    admins_root_url
  when "Staff"
    staffs_root_url
  when "Restaurant"
    restaurants_root_url
  else
    root_url
  end if user_signed_in?
end

end
