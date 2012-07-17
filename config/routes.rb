Store::Application.routes.draw do
  

  resources :user_coupons

  get "front/index"

  resources :fronts

  resources :coupons

  resources :merchant_locations

  resources :merchants

  resources :coupontypes

  resources :areas

  resources :cities

  resources :categories

  resources :gateways

  resources :carriers

  resources :products

  resources :users
  resources :user_sessions


  match 'login' => 'user_sessions#new', :as => :login
  match 'admin' => 'user_sessions#new', :as => :admin
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'log_out' => 'fronts#destroy', :as => :log_out
  match '/fronts_signin' => 'fronts#signin', :as => :fronts_signin
  match '/fronts_signup' => 'fronts#create', :as => :fronts_signup
  match '/profile_edit/:id' => 'fronts#edit', :as => :profile_edit
  match '/profile_update' => 'fronts#update', :as => :profile_update
  match 'coupon_filter/:id' => 'fronts#index', :as => :coupon_filter
  match 'get_coupon/:id' => 'fronts#get_coupon', :as => :get_coupon

  match 'coupon_filter_area/:area_id' => 'fronts#index', :as => :coupon_filter_area

  match '/forgot_password' => 'fronts#forgot_password', :as => :forgot_password
  match '/change_password' => 'fronts#change_password', :as => :change_password
  match '/privacypolicy' => 'fronts#privacypolicy', :as => :privacypolicy
  match '/contactus' => 'fronts#contactus', :as => :contactus
  match '/terms' => 'fronts#terms', :as => :terms



  
  match 'userlist/:ord/:name' => 'users#index', :as => :userlist

  match 'merchant_list/:id' => 'merchant_locations#index', :as => :merchant_list
  match 'coupon_list/:id' => 'coupons#index', :as => :coupon_list


  match '/getArea' => 'merchant_locations#list_area_by_city', :as => :list_area_by_city


  match '/auth/:provider/callback', :to => 'fronts#facebook_login'
  match '/auth/failure', :to => 'sessions#failure'


  root :to => 'fronts#index'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
