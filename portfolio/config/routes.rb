Rails.application.routes.draw do

  root 'application#hello'

  # for thumb
  get    'api/thumb'     => 'thumb#index'
  post   'api/thumb'     => 'thumb#create'
  get    'api/thumb/:id' => 'thumb#show'
  delete 'api/thumb/:id' => 'thumb#destroy'

  # for web-view
  resources :projects

  # for api
  get    'api/projects'     => 'projects#api_index'
  post   'api/projects'     => 'projects#api_create'
  get    'api/projects/:id' => 'projects#api_show'
  delete 'api/projects/:id' => 'projects#api_destroy'
  put    'api/projects/:id' => 'projects#api_update'
end
