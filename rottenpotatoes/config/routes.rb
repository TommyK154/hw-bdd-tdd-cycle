Rottenpotatoes::Application.routes.draw do
  resources :movies do
    member do get 'find_by_director' end
  end
  #get 'movies/:id/find_by_director' => 'movies#find_by_director', as: 'find_by_director_movie'
  
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')

end
