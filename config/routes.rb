GpoConference::Application.routes.draw do
  mount ElVfsClient::Engine => '/'

  namespace :manage do
    resources :conferences, :only => [] do
      resources :claims, only: :new

      resources :expert_claims do
        get 'with_state/:with_state', action: :index, on: :collection, as: :with_state
      end

      resources :project_member_claims, :only => [:new, :create, :show]

      resources :projects, :only => [] do
        resources :discourses, :except => :index
      end
    end

    root :to => 'application#index'
  end

  resources :conferences, :only => [] do
    resources :statistics
    resources :themes, :only => [:index, :show] do
      resources :projects, :only => [] do
        resources :discourses, :only => :show do
          resources :comments, :only => [:show, :new, :create]
        end
      end
    end
  end

  root :to => 'themes#index'
end
