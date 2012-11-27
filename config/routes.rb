Gloriasnotes::Application.routes.draw do
  resources :topics, :only => [:new, :create, :index, :show, :edit, :update, :destroy]

end 
