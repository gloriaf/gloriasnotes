Gloriasnotes::Application.routes.draw do
  resources :topics do
    resources :notes
  end

  root :to => redirect('/topics')

  # statics page
  match "help" =>    "static_pages#help"
  match "about" =>   "static_pages#about"
  match "contact" => "static_pages#contact"
  match "news" =>    "static_pages#news"

end 
