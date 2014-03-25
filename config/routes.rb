Homework::Application.routes.draw do
 
  root :to => 'repositories#index'
  match '/repositories/:owner/:name' => 'repositories#show', :as => 'repository'

  resources :repositories, :except => :show do
    collection do
      get :search
      get :chart
      get :committers
      get :commits
    end
  end

  current_api_routes = lambda do
    resources :repositories, only: [:index, :show] do
      resources :contributors, only: [:index, :show]
      resources :commits, only: [:index, :show]
    end
    match '/repositories/:owner/:name' => 'repositories#show', :as => 'repository'
    match '/repositories/:owner/:name/contributors' => 'contributors#index', :as => 'contributors'
    match '/repositories/:owner/:name/contributors/:id' => 'contributors#show', :as => 'contributors'
    match '/repositories/:owner/:name/commits' => 'commits#index', :as => 'commits'
    match '/repositories/:owner/:name/commits/:id' => 'commits#show', :as => 'commits'
  end

  namespace :api do
    scope :module => :v1, &current_api_routes
    namespace :v1, &current_api_routes
  end
  
end
