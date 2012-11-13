GpoConference::Application.routes.draw do
  namespace :manage do
    resources :claims
  end

  root to: 'application#welcome'
end
