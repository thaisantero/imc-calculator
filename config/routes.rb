Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :imc, only: :create
    end
  end
end
