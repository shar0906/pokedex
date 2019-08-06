Rails.application.routes.draw do

  get 'pokemons/index'
  
  get 'pokemons/:id', to: 'pokemons#show', as: 'pokemon'

  post 'pokemons/:search_term', to: 'pokemons#index'
  
  root 'pokemons#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end