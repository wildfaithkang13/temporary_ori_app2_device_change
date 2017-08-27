Rails.application.routes.draw do
  #get 'coupon_shop_lists/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  #get 'coupons/index'
  #get 'coupons' => 'coupons#index' #<<<<<この行を追加する

  root 'coupons#index'
  #get"sources/set_content"

  resources :coupons, only: [:index, :new, :edit, :update, :destroy, :create] do
    collection do
      post :confirm
    end
  end

  resources :coupon_shop_lists , only: [:index, :new, :create] do
    collection do
      post :confirm
    end
  end


end
