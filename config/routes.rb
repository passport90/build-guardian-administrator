Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "main#index"
  post "/", to: "main#select"
  post "/conclude", to: "main#conclude"
  post "/duty_debt_payment", to: "main#duty_debt_payment"
end
