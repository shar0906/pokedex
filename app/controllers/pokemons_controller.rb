class PokemonsController < ApplicationController
  require 'poke-api-v2'
  require 'unirest'

  def index
    @pokemons = []
    @pokemons_api = PokeApi.get(pokedex: 2).pokemon_entries
    @filter = Unirest.get("https://pokeapi.co/api/v2/type/",
                      headers:{ "Accept" => "application/json" }).body
    if params[:search_term]
      @pokemons_api.each do | pokemon |
        @pokemons.push(pokemon) if pokemon.pokemon_species.name.include?( params[:search_term] )
      end
    else
      @pokemons = @pokemons_api
    end
    if @pokemons.size == 1
      redirect_to :controller => "pokemons", :action => "show", :id => @pokemons[0].entry_number
    end
  end

  def show
    @pokemon = PokeApi.get(pokemon: params[:id])
    @shape = PokeApi.get(pokemon_shape: params[:id])
    @abilities = @pokemon.abilities
    @types = @pokemon.types
    @capture_rate = Unirest.get("https://pokeapi.co/api/v2/pokemon-species/" + params[:id] +"/",
                            headers:{ "Accept" => "application/json" }).body
  end
end

#export to json
#deploy to heroku