Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  #Deviseを継承したgeneral_usersとshop_managersを準備する
  devise_for :general_users, {
    path: 'general_users',
    controllers: {
      registrations: 'general_users/registrations',
      sessions: 'general_users/sessions'
    }
  }

  #スコープ名は単数系
  #devise_scopeとはデバイスの拡張機能で単数系で設定すること。
  devise_scope :general_user do
    get 'general_users/registrations/agreement' => 'general_users/registrations#agreement'
  end

  devise_for :shop_managers, {
    path: 'shop_managers',
    controllers: {
      registrations: 'shop_managers/registrations',
      sessions: 'shop_managers/sessions'
    }
  }

  devise_scope :shop_manager do
    get 'shop_managers/registrations/agreement' => 'shop_managers/registrations#agreement'
  end

  #root 'coupons#index'
  root 'top#index'

  resources :coupons do
    collection do
      post :confirm
      get :getcoupons
      get :question
      get :recruit
      #追加の場合はget XXXXを追加していく
    end
    #独自のアクションを追加する方法
    #collection do
      #get 'manager_login'
      #get 'login_check'
    #end
  end

  resources :coupon_shop_lists do
    collection do
      post :confirm
      get :myshop
      get :issuedcoupon
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
