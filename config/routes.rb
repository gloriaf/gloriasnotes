Gloriasnotes::Application.routes.draw do
  resources :topics do
    resources :notes
  end

  root :to => redirect('/topics')

end 
