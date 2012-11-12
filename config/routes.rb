GpoConference::Application.routes.draw do
  namespace :manage do
    resources :claims, :only => [:new, :create, :show]
  end

  root to: 'application#welcome'
end
