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


  namespace :admin do
    resources :questions
  end

end
