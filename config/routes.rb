Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        resources :sleep_logs, module: :users, only: %i[create]
      end
    end
  end
end
