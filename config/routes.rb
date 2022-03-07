Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
			namespace :auth do
				post 'sign_up', to: 'registrations#create'
				delete 'destroy', to: 'registrations#destroy'
				post 'sign_in', to: 'sessions#create'
				get 'validate_token', to: 'sessions#validate_token'
				delete 'sign_out', to: 'sessions#destroy'
				get 'confirm_email', to: 'confirmations#confirm_email'
				put 'resend_confirm_email', to: 'confirmations#resend_confirm_email'
			end
		end
	end

	# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

	# Defines the root path route ("/")
	# root "articles#index"
	resources :users
end
