Rails.application.routes.draw do
	root "pages#index"

	resources :users, only: [:create, :update]
  resources :passports, only: [:index, :show]
	resources :user_passports, only: [:create, :destroy]
	resources :groups, only: [:index, :show]

	get "/auth/:provider/callback", to: "sessions#create"

	get "/dashboard", to: "users#show", as: "user_dashboard"
	get  "/auth/facebook", as: "facebook_login"
	get  "/auth/failure",  to: redirect("/")
	get  "/login",  			 to: "sessions#new", as: "login"
	post "/login",  			 to: "sessions#create_from_email"
	get  "/logout", 			 to: "sessions#destroy"


end
