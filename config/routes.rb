Rails.application.routes.draw do
	root "pages#index"

	resources :users, only: [:create, :update]
	get  "/complete-registration", to: "users#complete", as: "complete_registration"

	get "/auth/:provider/callback", to: "sessions#create"

	get "/dashboard", to: "pages#dashboard", as: "user_dashboard"

	get  "/auth/facebook", as: "facebook_login"
	get  "/login",  			 to: "sessions#new"
	post "/login",  			 to: "sessions#create_from_email"
	get  "/logout", 			 to: "sessions#destroy"


end
