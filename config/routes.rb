Rails.application.routes.draw do
  root to: redirect('session/new')
  resources :users, only: [:new, :create, :show, :index]
  resource :session, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, only: :new, on: :member
  end

  resources :posts, except: :new
end
