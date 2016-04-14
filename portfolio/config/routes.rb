Rails.application.routes.draw do

  root 'application#hello'

  # for thumb
  get    'thumb/index'
  get    'thumb/show'
  post   'thumb/create'
  delete 'thumb/destroy'

  # for web-view
  resources :projects

  # for api
  get    'api/projects'     => 'projects#api_index'
  post   'api/projects'     => 'projects#api_create'
  get    'api/projects/:id' => 'projects#api_show'
  delete 'api/projects/:id' => 'projects#api_destroy'
  put    'api/projects/:id' => 'projects#api_update'
end
