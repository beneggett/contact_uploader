ContactUploader::Application.routes.draw do
  resources :posts


  get "/admin", to: "admin#index", as: :admin

  namespace :admin do
    get 'admin-users', to: "users#admin_users", as: :admin_users
    resources :users

  end

  devise_for :users,
              controllers: { omniauth_callbacks: "omniauth_callbacks" }

  root to: "home#index"

end
