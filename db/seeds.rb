# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

#Create DB with api

require 'open-uri'
require 'pry-byebug'

POKEMON_API = 'https://api.tcgdex.net/v2/fr/cards/'

SEASON_API = 'https://api.tcgdex.net/v2/fr/series'

EXTENSION_API = 'https://api.tcgdex.net/v2/fr/sets'

p 'Clear DB'
if Rails.env.development?
  AlbumPokemon.destroy_all
  Pokemon.destroy_all
  Extension.destroy_all
  Season.destroy_all
end

p 'open API Season'
open_api = URI.open(SEASON_API).read
json_season = JSON.parse(open_api)

p 'open API Extension'
open_api = URI.open(EXTENSION_API).read
json_extension = JSON.parse(open_api)

p 'open API Pokemon'
open_api = URI.open(POKEMON_API).read
json_pokemon = JSON.parse(open_api)

p 'create db season'
json_season.each do |season|
  db_season = Season.new(
    season_name: season['name'],
    season_acronym: season['id']
  )
  db_season.save!
end

p 'create db extension'
json_extension.each do |extension|
  db_extension = Extension.new(
    extension_name: extension['name'],
    extension_acronym: extension['id'],
    total: extension['cardCount']['total']
  )

  if extension['id'].match?('wp') || extension['id'].match?('jumbo') || extension['id'].match?('rc')
    id_season = Season.select(:id).where('season_acronym LIKE ?', 'misc')
  elsif extension['id'].match?('dc') || extension['id'].match?('g1')
    id_season = Season.select(:id).where('season_acronym LIKE ?', 'xy')
  elsif extension['id'].match?('cel')
    id_season = Season.select(:id).where('season_acronym LIKE ?', 'swsh')
  elsif extension['id'].match?('det1')
    id_season = Season.select(:id).where('season_acronym LIKE ?', 'sm')
  elsif extension['id'].match?('dv1')
    id_season = Season.select(:id).where('season_acronym LIKE ?', 'bw')
  elsif extension['id'].match?('np')
    id_season = Season.select(:id).where('season_acronym LIKE ?', 'pop')
  elsif extension['id'].match?(/^[0-9]/)
    id_season = Season.select(:id).where('season_acronym LIKE ?', 'mc')
  elsif extension['id'].match?(/[a-z]$/) && !extension['id'].include?('tk')
    extension_length = extension['id'].length - 1
    prefix_extension = extension['id'].slice(0, extension_length)
    id_season = Season.select(:id).where('season_acronym LIKE ?', prefix_extension)
  else
    id_season = Season.select(:id).where('season_acronym LIKE ?', extension['id'].match(/[a-z]+/).to_s)
  end
  db_extension.season_id = id_season.ids[0]
  db_extension.save!
end

# Extensions non dans l'API
ecard3 = Extension.new(
  extension_name: 'Skyridge',
  extension_acronym: 'ecard3',
  total: 182
)
ecard_id = Season.select(:id).where('season_acronym LIKE ?', 'ecard')
ecard3.season_id = ecard_id.ids[0]
ecard3.save!

pl4 = Extension.new(
  extension_name: 'Arceus',
  extension_acronym: 'pl4',
  total: 111
)
pl_id = Season.select(:id).where('season_acronym LIKE ?', 'pl')
pl4.season_id = pl_id.ids[0]
pl4.save!

p 'add data to pokemon'
json_pokemon.each do |pokemon|
  # Compare extension pokemon to extension table to take ID for the referencement
  extension = Extension.select(:id).where('extension_acronym LIKE ?', pokemon['id'].match(/[0-9]*[a-z]+[0-9]*(\.?5?)?((-[a-z]*)(-[a-z]*))?/).to_s)

  card_pokemon = Pokemon.new(
    pokemon_name: pokemon['name'],
    pokemon_index: pokemon['localId'],
    pokemon_id: pokemon['id'],
    image: "#{pokemon['image']}/high.webp"
  )

  card_pokemon.extension_id = extension.ids[0]

  # Take extension pokemon to search the api to the card specially
  extension_pokemon = pokemon['id']
  pokemon_api = "https://api.tcgdex.net/v2/fr/cards/#{extension_pokemon}"
  open_api = URI.open(pokemon_api).read
  json_pokemon = JSON.parse(open_api)

  # Check if category of the card is nil
  unless json_pokemon['category'].nil?
    card_pokemon.category = json_pokemon['category']
  end

  # Check if rarity of the card is nil
  unless json_pokemon['rarity'].nil?
    card_pokemon.rarity = json_pokemon['rarity']
  end

  # Check if attacks of the card is nil
  unless json_pokemon['attacks'].nil?
    attacks = json_pokemon['attacks']
    weaknesses = json_pokemon['weaknesses']
    resistences = json_pokemon['resistences']
    retreat = json_pokemon['retreat']
    types = json_pokemon['types']
    card_pokemon.metadata = {
      types: types,
      attaques: attacks,
      faiblesse: weaknesses,
      resistances: resistences,
      retraite: retreat
    }
  end

  unless json_pokemon['effect'].nil?
    effect = json_pokemon['effect']
    trainer = json_pokemon['trainerType']
    card_pokemon.metadata = {
      effet: effect,
      type_entraineur: trainer
    }
  end

  # binding.pry
  card_pokemon.save!

end

p 'finish'
