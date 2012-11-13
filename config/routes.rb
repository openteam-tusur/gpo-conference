GpoConference::Application.routes.draw do
  mount ElVfsClient::Engine => '/'

  namespace :manage do
    resources :claims, only: :new

    resources :expert_claims
    resources :project_member_claims
    root :to => 'application#index'
  end

  root to: 'application#welcome'
end
