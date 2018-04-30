Rails.application.routes.draw do

  root 'questions#index'
  match 'questions/vote/:id' => 'questions#vote', :via => :post
  resources :questions



end
