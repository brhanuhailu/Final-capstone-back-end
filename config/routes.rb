Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    namespace :v1 do
      resources :houses , only: [:index, :create, :show, :destroy] do
        collection do
          get 'userhouses'
        end
        resources :reservations , only: [:index, :create, :destroy]
      end
      get 'myreservations', to: 'reservations#my_reservations'
    end
  end
end
