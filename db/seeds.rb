# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'
require 'pry-byebug'

POKEMON_API = 'https://api.tcgdex.net/v2/fr/cards/'

SEASON_API = 'https://api.tcgdex.net/v2/fr/series'

EXTENSION_API = 'https://api.tcgdex.net/v2/fr/sets'

p 'Clear DB'
if Rails.env.development?
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
    extension_acronym: extension['id']
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
  extension_acronym: 'ecard3'
)
ecard_id = Season.select(:id).where('season_acronym LIKE ?', 'ecard')
ecard3.season_id = ecard_id.ids[0]
ecard3.save!

pl4 = Extension.new(
  extension_name: 'Arceus',
  extension_acronym: 'pl4'
)
pl_id = Season.select(:id).where('season_acronym LIKE ?', 'pl')
pl4.season_id = pl_id.ids[0]
pl4.save!

p 'create pokemon card'
json_pokemon.each do |pokemon|
  extension_pokemon = Extension.select(:id).where('extension_acronym LIKE ?', pokemon['id'].match(/[0-9]*[a-z]+[0-9]*(\.?5?)?((-[a-z]*)(-[a-z]*))?/).to_s)

  card_pokemon = Pokemon.new(
    pokemon_name: pokemon['name'],
    pokemon_index: pokemon['localId'],
    image: "#{pokemon['image']}/high.webp"
  )

  card_pokemon.extension_id = extension_pokemon.ids[0]
  card_pokemon.save!
end

p 'finish'
