GpoConference::Application.routes.draw do
  mount ElVfsClient::Engine => '/'

  namespace :manage do
    resources :claims, only: :new

    resources :expert_claims do
      get 'with_state/:with_state', action: :index, on: :collection, as: :with_state
    end

    resources :project_member_claims, :only => [:new, :create, :show]

    resources :projects, :only => [] do
      resources :discourses, :except => :index
    end

    root :to => 'application#index'
  end

  scope :module => :public do
    resources :themes, :only => [:index, :show] do
      resources :projects, :only => [] do
        resources :discourses, :only => :show
      end
    end
  end

  root to: 'application#welcome'
end
