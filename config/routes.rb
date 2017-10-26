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

  devise_scope :general_users do
    get 'general_users/registrations/agreement', :action => 'agreement', :controller => 'general_users/registrations', :as => 'general_users_agreement'
  end

  #利用規約同意画面の参考ページ
  #http://hirosasaki.hateblo.jp/entry/2013/03/01/Devise%E3%81%A8simple_form%E3%81%A7%E4%BC%9A%E5%93%A1%E7%99%BB%E9%8C%B2%E3%81%99%E3%82%8B%E3%81%A8%E3%81%8D%E3%81%AE%E5%88%A9%E7%94%A8%E8%A6%8F%E7%B4%84%E3%81%B8%E3%81%AE%E5%90%8C%E6%84%8F%E7%A2%BA

  devise_for :shop_managers, {
    path: 'shop_managers',
    controllers: {
      registrations: 'shop_managers/registrations',
      sessions: 'shop_managers/sessions'
    }
  }

  root 'coupons#index'

  resources :coupons do
    collection do
      post :confirm
      get :getcoupons
      get :question
      #追加の場合はget XXXXを追加していく
    end
    #独自のアクションを類歌する方法
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
