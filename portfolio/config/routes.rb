Rails.application.routes.draw do
  root 'application#hello'

  resources :projects, :path => 'api/projects'
end
