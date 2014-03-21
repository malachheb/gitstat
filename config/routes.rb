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
  
end
