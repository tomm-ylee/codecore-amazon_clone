Rails.application.routes.draw do

  resources :faqs, only: [:create]


  # Home Controller HTTP VERB Routes
  get('/', {to: 'home#index', as: :root})
  get('/faq', {to: 'home#faq'})

  # About Controller HTTP VERB Routes
  get('/about', {to: 'about#index'})

  # Questions Controller HTTP VERB Routes
  delete('/questions/:id', {to: 'questions#destory'})
  get('/questions/:id/edit', {to: 'questions#edit'})
  get('/questions/:id', {to: 'questions#show'})

  # Comments Controller HTTP VERB Routes
  post('/questions/:id/comments', {to: 'comments#create'})

  #  Contact Controller HTTP VERBS Routes
  get('/contact', {to: 'contact#index'})

  post('/contact', {to: 'contact#submit'})

  # # Products Controller HTTP VERBS Routes
  #
  # # Products#new
  # get('products/new', to: 'products#new', as: :new_product)
  #
  # # Products#create
  # post('products', to: 'products#create', as: :products)
  #
  # # Products#show
  # get('products/:id', to: 'products#show', as: :product)
  #
  # # Product#index
  # get('products', to: 'products#index')
  #
  # # Product#destroy
  # delete('products/:id', to: 'products#destroy')
  #
  # # Product#edit
  # get('products/:id/edit', to: 'products#edit', as: :edit_product)
  #
  # # Product#update
  # patch('products/:id', to: 'products#update')

  resources :products, shallow: true do
    resources :reviews, only: [:create, :destroy]
    resources :favourites, only: [:create, :destroy]
  end

  resources :reviews, only: [], shallow: true do
    resources :likes, only: [:create, :destroy]
    resources :votes, only: [:create, :update, :destroy]
  end

  patch('review/hide/:id', to: 'reviews#hide', as: :hide_review)

  resources :users, only: [:new, :create, :show] do
    resources :favourites, only: [:index], shallow: true
  end

  resource :session, only: [:new, :create, :destroy]

  namespace :admin do
    resources :panel, only: [:index]
  end

  resources :news_articles

  resources :tags, only: [:index, :show]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :products, only: [:index, :show, :create]
      resources :users, only: [:create]
      resources :tokens, only: [:create, :destroy]
    end

    match "*unmatched_route", to: "application#not_found", via: :all
  end

  match "delayed_job", to: DelayedJobWeb, anchor: false, via: [:get, :post]


end
