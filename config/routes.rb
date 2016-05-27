Rails.application.routes.draw do
	root "pages#index"
	get "/auth/:provider/callback", to: "sessions#create"
	get "/logout", to: "sessions#destroy"
end
