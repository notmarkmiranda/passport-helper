Rails.application.routes.draw do
	root "pages#index"

	resources :users, only: [:create, :update, :edit] do
		scope module: "users" do
			resources :passports, only: [:show], as: "u_passport"
		end
	end
  resources :passports, only: [:index, :show]
	resources :user_passports, only: [:create, :destroy]
	resources :groups, only: [:index, :show, :new, :create]
	resources :memberships, only: [:destroy, :create]

	namespace :api, defaults: {format: :json} do
		namespace :v1 do
			delete "/visits", to: "visits#destroy"
			resources :visits, only: [:index, :create]
		end
	end

	get "/auth/:provider/callback", to: "sessions#create"

	get  "/dashboard", to: "users#show", as: "user_dashboard"
	get  "/auth/facebook/callback", to: "sessions#create"
	post "/auth/facebook/callback", to: "sessions#create"
	get  "/auth/facebook", as: "facebook_login"
	get  "/auth/failure",  to: redirect("/")
	get  "/login",  			 to: "sessions#new", as: "login"
	post "/login",  			 to: "sessions#create_from_email"
	get  "/logout", 			 to: "sessions#destroy"

end
