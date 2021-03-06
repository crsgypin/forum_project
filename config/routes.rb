Rails.application.routes.draw do

  get 'about' => "abouts#index"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only: :show do
    
    resource :profile
    member do
      get :articles
      get :comments
      get :like_articles

      get :draft
      get :favorite

      get :friends
    end
  end

  resources :friends do 
    member do
      get :send_invitation
      get :cancel_invitation
      get :accept_invitation
      get :ignore_invitation
      get :reject_invitation
      get :block_my_friend
      get :unblock_my_friend
      post :select_relation_tag
    end
  end

  resources :articles do
    resources :comments
    member do
      post :add_favorite
      post :remove_favorite
      post :like
      get :like_users
    end
  end

  namespace :admin do
    resources :articles
    resources :categories
    resources :users
  end

  root :to => 'articles#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
