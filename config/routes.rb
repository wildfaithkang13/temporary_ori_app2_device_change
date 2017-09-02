Rails.application.routes.draw do

  get 'coupon_shop_lists/geocode'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #Deviseを継承したgeneral_usersとshop_managersを準備する
  devise_for :general_users, {
    path: 'general_users',
    controllers: {
      registrations: 'general_users/registrations'
    }
  }

  devise_for :shop_managers, {
    path: 'shop_managers',
    controllers: {
      registrations: 'shop_managers/registrations',
      sessions: 'shop_managers/sessions'
    }
  }

  root 'coupons#index'

  resources :coupons, only: [:index, :new, :edit, :update, :destroy, :create] do
    collection do
      post :confirm
    end
    #独自のアクションを類歌する方法
    #collection do
      #get 'manager_login'
      #get 'login_check'
    #end
  end

  resources :coupon_shop_lists , only: [:index, :new, :create] do
    collection do
      post :confirm
    end
  end
end
