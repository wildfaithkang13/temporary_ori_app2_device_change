Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #Deviseを継承したgeneral_usersとshop_managersを準備する
  # devise_scope :general_users do
  #
  # end
  get 'agreements', to: "general_users/agreements#index"

  #利用規約同意画面の参考ページ
  #http://hirosasaki.hateblo.jp/entry/2013/03/01/Devise%E3%81%A8simple_form%E3%81%A7%E4%BC%9A%E5%93%A1%E7%99%BB%E9%8C%B2%E3%81%99%E3%82%8B%E3%81%A8%E3%81%8D%E3%81%AE%E5%88%A9%E7%94%A8%E8%A6%8F%E7%B4%84%E3%81%B8%E3%81%AE%E5%90%8C%E6%84%8F%E7%A2%BA

  devise_for :shop_managers, {
    path: 'shop_managers',
    controllers: {
      registrations: 'shop_managers/registrations',
      sessions: 'shop_managers/sessions'
      #get '/users/sign_out' => 'shop_manager/sessions#destroy'
    }
  }

  #devise_scope :general_users do
  #get 'get_token' => 'sessions#get_token'
  #get 'get_token' => 'general_users#registrations#get_token'

  #get 'agreement_general_user_registration' => 'general_users#registrations#agreement'

  #general_users/registrations
  #end

  devise_scope :general_users do
    get 'agreement', :action => 'agreement', :controller => 'general_users/registrations', :as => 'agreement'
  end

  root 'coupons#index'

  resources :coupons do
    collection do
      post :confirm
      get :getcoupons
      #get :agreement
      #追加の場合はget XXXXを追加していく
    end
    #独自のアクションを類歌する方法
    #collection do
      #get 'manager_login'
      #get 'login_check'
    #end
  end

  #resources :coupon_shop_lists , only: [:index, :new, :create] do
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
