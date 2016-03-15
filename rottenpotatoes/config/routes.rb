Rottenpotatoes::Application.routes.draw do
  resources :movies
  #get 'movies/:id/find_by_director' => 'movies#find_by_director', 
    #as => :find_by_director_movie
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  
  get '/similar-movies/:id', to: 'movies#similar_movies', as: 'similar_movies'
end
