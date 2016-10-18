Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: "json" } do
  	resources :users

  	resources :posts
  	get "my_posts" => "posts#my_posts"
  	
  	resources :comments

  	resources :beacons
    get "my_beacons" => "beacons#my_beacons"


  	resources :sessions, except: [:update, :show]
  end

end
