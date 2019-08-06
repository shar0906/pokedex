class Api::PokemonsController < Api::ApplicationController
  def snapshot
    render json: PokedexReport.new(project: @pokemons).results.hashes
  end
end