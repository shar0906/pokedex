class PokemonsController < ApplicationController
  require 'poke-api-v2'
  require 'dossier'

  def index
    @pokemon = PokeApi.get(pokemon: params[:id]) 
    @pokemons = []
    @pokemons_api = PokeApi.get(pokedex: 2).pokemon_entries
  
    if params[:search_term]
      @pokemons_api.each do | pokemon |
        @pokemons_api.push(pokemon) if pokemon.pokemon_species.name.include?( params[:search_term] )
      end
    else
      @pokemons = @pokemons_api
    end
    if @pokemons.size == 1
      # redirect_to :controller => "pokemons", :action => "show", :id => @pokemons[0].entry_number
    end

    render json: @pokemons
  end

  def show
    @pokemon = PokeApi.get(pokemon: params[:id])
    @shape = PokeApi.get(pokemon_shape: params[:id])
    @abilities = @pokemon.abilities
    @types = @pokemon.types
  end
end


# how to create a get method in ruby using routes
# how to create a get request with a url to get anything

#allow search queries to search for pokemon by name
#add show option for detailed pokemon info
  # - name
  # -id
  # -capture rate (%)
  # -type
  # -shape
#filter by type
#export to json
#icon for each pokemon
#show page shows sprite as well
#deploy to heroku