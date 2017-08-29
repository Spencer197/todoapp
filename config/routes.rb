Rails.application.routes.draw do
  
  root "pages#home"#Root goes to pages controller, home action.
  get '/about', to: 'pages#about'#Get the '/about' route and send it to the Pages controller, about action.
  get '/help', to: 'pages#help'#Get the '/help' route and send it to the pages controller, help action.
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :todos
end