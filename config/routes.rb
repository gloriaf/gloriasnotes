Gloriasnotes::Application.routes.draw do
  resources :topics

  root :to => redirect('/topics')

end 
