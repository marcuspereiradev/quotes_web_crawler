Rails.application.routes.draw do
  devise_for :users
  scope module: :api do
    scope module: :v1 do
      resources :quotes, only: [:index, :update, :destroy]
      get 'quotes/:search_tag', to: 'quotes#find_quotes'
    end
  end
end
