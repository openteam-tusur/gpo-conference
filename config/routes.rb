GpoConference::Application.routes.draw do
  mount ElVfsClient::Engine => '/'

  namespace :manage do
    resources :conferences,             :except => :show do
      resources :claims,                :only => [:index, :update, :destroy]
    end

    root :to => 'conferences#index'
  end

  resource :dashboard,                  :only => [:show]
  resources :conference,                :only => [] do
    resources :project_member_claims,   :only => [:new, :create]
    resources :expert_claims,           :only => [:new, :create]
    resource  :statistics,              :only => [:show]
    resources :themes,                  :only => [:index, :show] do
      resources :projects,              :only => [] do
        resources :discourses,          :only => [:show, :new, :create, :update, :edit, :destroy] do
          resources :comments,          :only => [:show, :new, :create]
        end
      end
    end
  end

  root :to => 'themes#index'
end
