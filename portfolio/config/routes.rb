Rails.application.routes.draw do
  root 'application#hello'

  resources :projects, :path => 'api/projects'
  get 'test/delete/:id' => 'projects#destroy'
end
