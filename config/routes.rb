Rails.application.routes.draw do
  
  root "pages#home"#Root goes to pages controller, home action.
  get 'pages/home', to: 'pages#home'#Get the '/home' route and send it to the Pages Controller, home action.
  get '/about', to: 'pages#about'#Get the '/about' route and send it to the Pages controller, about action.
  get '/help', to: 'pages#help'#Get the '/help' route and send it to the pages controller, help action.
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :todos
  
  get '/signup', to: 'users#new'#This line directs the '/signup' route to the user controller, new action rather than the new route.
  resources :users, except: [:new]#Makes an exception of 'new' so that it is replaced by 'signup'.
  
  get '/login', to: 'sessions#new'#Goes to sessions controller, new action.
  post '/login', to: 'sessions#create'#This will submit/post the login new session form to the sessions controller, create action.
  delete '/logout', to: 'sessions#destroy'#This goes down the logout path to the sessions controller, destroy action.
  
  resources :factors, except: [:destroy]
end