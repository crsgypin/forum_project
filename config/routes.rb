Rails.application.routes.draw do
  get 'articles/new'
  get 'about', :controller=>'abouts', :action=>'index'

  devise_for :users
  resources :users, only: :show do
    member do
      get :profile, :action=>:show_profile
      get :edit_profile, :action=>:edit_profile
      patch :profile, :action=>:update_profile
      get :articles, :action=>:posted_articles
      get :comments, :action=>:posted_comments
      get :draft, :action=>:draft
      get :favorite, :action=>:favorite
      delete :favorite, :action=>:favorite_delete
    end
  end



  resources :articles do
    resources :comments
    member do
      post :favorite, :action=>:favorite_create
      delete :favorite, :action=>:favorite_delete
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
