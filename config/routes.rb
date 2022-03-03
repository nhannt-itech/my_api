Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :auth do
        post "sign_up", to: "registrations#create"
        delete "destroy", to: "registrations#destroy"
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
