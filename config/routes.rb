Rails.application.routes.draw do

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

  # Products Controller HTTP VERBS Routes

  # Products#new
  get('products/new', to: 'products#new', as: :new_product)

  # Products#create
  post('products', to: 'products#create', as: :products)

  # Products#show
  get('products/:id', to: 'products#show', as: :product)

  # Product#index
  get('products', to: 'products#index')

  # Product#destroy
  delete('products/:id', to: 'products#destroy')

  # Product#edit
  get('products/:id/edit', to: 'products#edit', as: :edit_product)

  # Product#update
  patch('products/:id', to: 'products#update')

  namespace :admin do
    resources :questions
  end

end
