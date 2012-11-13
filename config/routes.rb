GpoConference::Application.routes.draw do
  namespace :manage do
    resources :claims, only: :new

    resources :expert_claims
    resources :project_member_claims
  end

  root to: 'application#welcome'
end
