Rails.application.routes.draw do
  devise_for :admin, controllers: {
    sessions:      'admin/sessions',
    passwords:     'admin/passwords',
    registrations: 'admin/registrations'
  }
  devise_for :recommender, controllers: {
    sessions:      'recommender/sessions',
    passwords:     'recommender/passwords',
    registrations: 'recommender/registrations'
  }
  root 'tops#index'

  get  'topics'              => 'topics#index'
  get  'topics/:id'          => 'topics#show',as: "topic_show"
  get  'categories/:id'      => 'categories#index',as: 'category'
  get  'needs/:id'           => 'needs#index',as:'need'

  namespace :admin do
    get  '/'                 => 'topics#index'
    get  'topics/new'        => 'topics#new'
    post 'topics/create'     => 'topics#create'
    get  'topics/:id/edit'   => 'topics#edit',as: 'topics_edit'
    post 'topics/:id/save'   => 'topics#save',as: 'topics_save'
    get  'categories'        => 'categories#index'
    post 'categories/create' => 'categories#create'
    get  'needs'             => 'needs#index'
    post 'needs/create'      => 'needs#create'
    post 'topics/:topic_id/add_image' => 'topics#add_image',as:'add_image'
  end

  namespace :recommender do
    get  '/' => 'products#index'
    post 'products/create'  => 'products#create'
    get  'products/new'     => 'products#new'
    get  'products/:product_id/edit'  => 'products#edit',as: "products_edit"
    post  'products/:product_id/save'  => 'products#save',as: "products_save"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end