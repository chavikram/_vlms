Rails.application.routes.draw do
 
  get 'categories/index'
  get 'categories/edit'
  get 'categories/destroy'
  get 'categories/new'
  get 'categories/create'
  get 'category/index'
  get 'category/edit'
  get 'category/destroy'
  get 'category/new'
  get 'category/create'
  get 'categories/listofSubCategories'
  
  resources :designations
  
  get 'vip_ref_transfers/index'
  get 'vip_ref_transfers/new'
  get 'vip_ref_transfers/delete'
  get 'vip_ref_summaries/new'
  get 'vip_ref_summaries/index'
  get 'vip_ref_summaries/create'
  get 'vip_ref_summaries/destroy'
  get 'vip_ref_summaries/edit'
  get 'vip_ref_summaries/update'

  get 'vip_ref_app/inbox_section'
  get 'vip_ref_app/inbox'
  get 'vip_ref_app/draft'
  get 'vip_ref_app/sent'
  get 'vip_ref_app/home'
  get 'vip_ref_app/homescreen'
  get 'vip_ref_app/pending_report'
  get 'vip_ref_app/pending_report_1'
  get 'vip_ref_app/disposalreport'

  get 'vip_ref_app/monthwisereport'
  get 'vip_ref_app/statewisereport'
  
  
  
  get 'vip_ref_app/category_wise_pendency'
  get 'vip_ref_app/report'

  
  get 'vip_ref_app/closed'
  get 'vip_ref_app/chart'

  get 'vip_reference_movements/index'

  get 'vip_references/report'
  get 'vip_references/index'

  get 'vip_references/update'

  get 'vip_references/delete'

  get 'vip_references/new'

  get 'complaint_status/index'

  get 'complaint_status/update'

  get 'complaint_status/delete'

  get 'complaint_status/new'

  get 'complaint_status/create'
  
  #root 'complaints#home'
  root 'vip_ref_app#homescreen'
  resources :categories
  resources :vip_categories do
    member do
      get :referencelist
    end
  end
  resources :vip_ref_statuses
  resources :sections do
      member do
        
        get :pending_lessthan_1mth
        get :pending_lessthan_3mth
        get :pending_morethan_3mth
        get :updated_today
        
      end
  end
  
  resources :statuses
  resources :designations
  resources :countries do
    get 'update_states'
    resources :states
  end
  match '/complaints/search_form' => 'complaints#search_form', :via=> :get, :as => :search_form

  resources :complaints do
    resources :complaint_movements
    collection do
      get 'home'
      get 'move'
     end
  end
  
  resources :complaint_types
  resources :handlers
  resources :offices do
      resources :contacts do
        resources :feedbacks do
          resources :feedback_replies
        end
        
      end 
  end
    resources :vip_references do
    resources :vip_ref_summaries
    member do
      get :send
      post :move_to_inbox
    end

    resources :vip_ref_transfers do
    end
    
    resources :vip_ref_movements do
      get 'read'
      collection do
        get 'send'
      end
    end
  end
  
  resources :homes

  devise_for :users, :controllers => {:registrations => "registrations",:sessions=>"sessions"},path_names: {sign_up: 'signup', sign_in: 'login', sign_out: 'logout'}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
