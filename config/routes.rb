Rails.application.routes.draw do
  scope module: :api do
    scope module: :v1 do
      get 'quotes/:search_tag', to: 'quotes#find_quotes'
    end
  end
end
