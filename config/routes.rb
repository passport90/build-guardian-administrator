Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "main#index"
  post "/authenticate", to: "main#authenticate"
  post "/", to: "main#select"
  post "/begin_round", to: "main#begin_round"
  post "/conclude", to: "main#conclude"
  post "/pay_duty_debt", to: "main#pay_duty_debt"

  resources :engineers
end
