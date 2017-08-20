Rails.application.routes.draw do
  #get 'coupons/index'
  #get 'coupons' => 'coupons#index' #<<<<<この行を追加する

  root 'coupons#index'

end
