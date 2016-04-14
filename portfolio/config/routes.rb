Rails.application.routes.draw do

  root 'static_pages#home'
  get 'help'  => 'static_pages#help'
  get 'about' => 'static_pages#about'

  resources :thumb, :path => 'api/thumbs',
            only: [:index, :create, :show, :destroy]

  resources :projects

  get    'api/projects'     => 'projects#api_index'
  post   'api/projects'     => 'projects#api_create'
  get    'api/projects/:id' => 'projects#api_show'
  delete 'api/projects/:id' => 'projects#api_destroy'
  put    'api/projects/:id' => 'projects#api_update'
end
