Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "quotes/:search_tag", to: "quotes#index"
    end
  end
end
