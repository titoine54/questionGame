Rails.application.routes.draw do

  root 'questions#index'
  match 'questions/vote/:id' => 'questions#vote', :via => :post
  match 'questions/game' => 'questions#game', :via => :get
  resources :questions



end
