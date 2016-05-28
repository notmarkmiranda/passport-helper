Rails.application.routes.draw do
	root "pages#index"
	get "/auth/:provider/callback", to: "sessions#create"

	get "/dashboard", to: "pages#dashboard", as: "user_dashboard"

	get  "/login",  to: "sessions#new"
	post "/login",  to: "sessions#create_from_email"
	get  "/logout", to: "sessions#destroy"
end
