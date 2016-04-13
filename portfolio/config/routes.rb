Rails.application.routes.draw do
  root 'application#hello'

  # for web-view
  resources :projects

  # for api
  get    'api/projects'     => 'projects#api_index'
  post   'api/projects'     => 'projects#api_create'
  get    'api/projects/:id' => 'projects#api_show'
  delete 'api/projects/:id' => 'projects#api_destroy'
end
