Rails.application.routes.draw do
  root 'application#hello'

  # for web-view
  # get    'projects'     => 'projects#index'
  # post   'projects'     => 'projects#create'
  # get    'projects/:id' => 'projects#show'
  # delete 'projects/:id' => 'projects#destroy'
  resources :projects

  # for api
  get    'api/projects'     => 'projects#api_index'
  post   'api/projects'     => 'projects#api_create'
  get    'api/projects/:id' => 'projects#api_show'
  delete 'api/projects/:id' => 'projects#api_destroy'
end
